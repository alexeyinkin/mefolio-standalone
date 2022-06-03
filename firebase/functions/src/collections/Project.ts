import * as admin from "firebase-admin";
import * as functions from "firebase-functions";

import {Project, fromIdAndMap, getProjectKeywords, getProjectTagsMap} from "../interfaces/models/Project";
import {getById as getTagById, createById as createTagById} from "./Tag";
import {StringObject} from "../interfaces/maps";
import {fixDate} from "../util/util";

const listenPath = "/Project/{id}";

export const Project_onCreate = functions.firestore.document(listenPath).onCreate(async (snapshot, context) => {
    const id = context.params.id;
    const map = snapshot.data();

    await fixTypes(id, map);

    const obj = fromIdAndMap(id, map);

    await updateDerivedFields(id, obj);
    await createTagsIfNot(id, obj);
});

export const Project_onUpdate = functions.firestore.document(listenPath).onUpdate(async (change, context) => {
    const id = context.params.id;
    const map = change.after.data();

    await fixTypes(id, map);

    const obj = fromIdAndMap(id, map);

    await updateDerivedFields(id, obj);
    await createTagsIfNot(id, obj);
});

async function updateDerivedFields(id: string, obj: Project | undefined): Promise<void> {
    const docRef = admin.firestore().doc(`Project/${id}`);

    if (obj === undefined) {
        const doc = await docRef.get();
        obj = doc.data() as Project | undefined;
    }

    if (obj === undefined) {
        // TODO: Log error.
        return;
    }

    const set = {
        keywords: getProjectKeywords(obj),
        tagsMap: getProjectTagsMap(obj),
    };

    await docRef.update(set);
}

async function fixTypes(id: string, map: StringObject): Promise<void> {
    await fixDate(map, 'dateTimeEnd', `Project/${id}`);
    await fixDate(map, 'dateTimeRelease', `Project/${id}`);
    await fixDate(map, 'dateTimeStart', `Project/${id}`);
}

async function createTagsIfNot(id: string, obj: Project): Promise<void> {
    for (const tag of obj.tags) {
        const tagObj = await getTagById(tag);
        if (tagObj !== undefined) continue;

        await createTagById(tag);
    }
}

export async function getAll(): Promise<Project[]> {
    const querySnapshot = await admin.firestore().collection("Project").get();
    const result = new Array<Project>();

    for (const doc of querySnapshot.docs) {
        result.push(fromIdAndMap(doc.id, doc.data()));
    }

    return result;
}
