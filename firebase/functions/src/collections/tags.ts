import * as admin from "firebase-admin";
import * as functions from "firebase-functions";

import {Tag, fromIdAndMap, toSaveMap} from "../interfaces/Tag";
import {deleteEntry, updateEntry} from "./dictionaries";

const listenPath = "/tags/{id}";
const dictionaryId = "tags";

export const tags_onCreate = functions.firestore.document(listenPath).onCreate(async (snapshot, context) => {
    const id = context.params.id;
    const map = snapshot.data();
    const obj = fromIdAndMap(id, map);

    await updateEntry(dictionaryId, fromIdAndMap, toSaveMap, obj);
});

export const tags_onUpdate = functions.firestore.document(listenPath).onUpdate(async (change, context) => {
    const id = context.params.id;
    const map = change.after.data();
    const obj = fromIdAndMap(id, map);

    await updateEntry(dictionaryId, fromIdAndMap, toSaveMap, obj);
});

export const tags_onDelete = functions.firestore.document(listenPath).onDelete(async (snapshot, context) => {
    const id = context.params.id;

    await deleteEntry(dictionaryId, fromIdAndMap, toSaveMap, id);
});

export async function getById(id: string): Promise<Tag | undefined> {
    const doc = await admin.firestore().doc(`tags/${id}`).get();
    const map = doc.data();

    if (map === undefined) return undefined;

    return fromIdAndMap(doc.id, map);
}

export async function createById(id: string): Promise<void> {
    const docRef = await admin.firestore().doc(`tags/${id}`);
    const map = {
        fixMe: true, // New docs require interference to manually set title.
    };

    await docRef.create(map);
}
