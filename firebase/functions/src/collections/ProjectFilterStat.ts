import * as admin from "firebase-admin";

import CollectionReference = admin.firestore.CollectionReference;
import DocumentData = admin.firestore.DocumentData;

import {getId as getFilterId} from "../interfaces/filters/ProjectFilter";
import {getAllPossibleFilters} from "../interfaces/models/Project";
import {ProjectFilterStat, getEmpty as getEmptyStat, toSaveMap} from "../interfaces/models/ProjectFilterStat";
import {getAll as getAllProjects} from "./Project";

export async function update(): Promise<void> {
    const stats = new Map<string, ProjectFilterStat>();
    const projects = await getAllProjects();

    for (const project of projects) {
        const filters = getAllPossibleFilters(project);

        for (const filter of filters) {
            const id = getFilterId(filter);
            const stat = stats.get(id) || getEmptyStat(id);

            stat.count++;
            stats.set(id, stat);
        }
    }

    await clear();
    await saveAll(stats.values());
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
