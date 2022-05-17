import * as admin from "firebase-admin";
import * as functions from "firebase-functions";

import {Project, fromMap, getKeywords} from "../interfaces/Project";
import {StringMap} from "../interfaces/StringMap";
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
        titleExclamation: obj["title"] + "!",
        keywords: getKeywords(obj),
    };

    await docRef.update(set);
}

async function fixTypes(id: string, map: StringMap): Promise<void> {
    await fixDate(map, 'dateTime', `projects/${id}`);
}
