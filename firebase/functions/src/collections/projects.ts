import * as admin from "firebase-admin";
import * as functions from "firebase-functions";

import {Project, fromMap, getProjectKeywords, getProjectTagsMap} from "../interfaces/Project";
import {StringObject} from "../interfaces/maps";
import {fixDate} from "../util/util";

const listenPath = "/projects/{id}";

export const projects_onCreate = functions.firestore.document(listenPath).onCreate(async (snapshot, context) => {
    const id = context.params.id;
    const map = snapshot.data();

    await fixTypes(id, map);
    await updateDerivedFields(id, fromMap(map));
});

export const projects_onUpdate = functions.firestore.document(listenPath).onUpdate(async (change, context) => {
    const id = context.params.id;
    const map = change.after.data();

    await fixTypes(id, map);
    await updateDerivedFields(id, fromMap(map));
});

async function updateDerivedFields(id: string, obj: Project | undefined): Promise<void> {
    const docRef = admin.firestore().doc(`projects/${id}`);

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
    await fixDate(map, 'dateTime', `projects/${id}`);
}
