import * as admin from "firebase-admin";

import CollectionReference = admin.firestore.CollectionReference;
import DocumentData = admin.firestore.DocumentData;

import {getId as getFilterId} from "../interfaces/filters/ProjectFilter";
import {getAllPossibleFilters} from "../interfaces/models/Project";
import {ProjectFilterStat, getEmpty as getEmptyStat, toSaveMap} from "../interfaces/models/ProjectFilterStat";
import {getAll as getAllProjects} from "./Project";

export async function update(): Promise<void> {
    const stats = await getBare();
    addGraphs(stats);

    await clear();
    await saveAll(stats.values());
}

async function getBare(): Promise<Map<string, ProjectFilterStat>> {
    const result = new Map<string, ProjectFilterStat>();
    const projects = await getAllProjects();

    for (const project of projects) {
        const filters = getAllPossibleFilters(project);

        for (const filter of filters) {
            const id = getFilterId(filter);
            const stat = result.get(id) || getEmptyStat(id, filter);

            stat.count++;
            result.set(id, stat);
        }
    }

    return result;
}

function addGraphs(stats: Map<string, ProjectFilterStat>): void {
    for (const stat of stats.values()) {
        addTagsAndGraph(stats, stat);
        addYearGraph(stats, stat);
    }
}

function addTagsAndGraph(stats: Map<string, ProjectFilterStat>, stat: ProjectFilterStat): void {
    for (const tag of stat.filter.tagsAnd) {
        const looserFilter = {
            tagsAnd: stat.filter.tagsAnd.filter(t => t !== tag),
            year: stat.filter.year,
        };

        const id = getFilterId(looserFilter);

        const looserStat = stats.get(id);
        if (looserStat === undefined) {
            // TODO: Log error
            continue;
        }

        looserStat.tagsAnd[tag] = {
            count: stat.count,
        };
    }
}

function addYearGraph(stats: Map<string, ProjectFilterStat>, stat: ProjectFilterStat): void {
    if (stat.filter.year === undefined) return;

    const looserFilter = {
        tagsAnd: stat.filter.tagsAnd,
        year: undefined,
    };

    const id = getFilterId(looserFilter);

    const looserStat = stats.get(id);
    if (looserStat === undefined) {
        // TODO: Log error
        return;
    }

    looserStat.year[stat.filter.year] = {
        count: stat.count,
    }
}

async function clear(): Promise<void> {
    await admin.firestore().recursiveDelete(
        getCollectionRef(),
    );
}

async function saveAll(stats: Iterable<ProjectFilterStat>): Promise<void> {
    // TODO: Split into batches?

    const collectionRef = getCollectionRef();
    for (const stat of stats) {
        await collectionRef.doc(stat.id).set(toSaveMap(stat));
    }
}

function getCollectionRef(): CollectionReference<DocumentData> {
    return admin.firestore().collection("ProjectFilterStat");
}
