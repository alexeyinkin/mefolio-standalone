import * as admin from "firebase-admin";
import * as functions from "firebase-functions";

import {Tag, fromIdAndMap, toSaveMap} from "../interfaces/models/Tag";
import {deleteEntry, updateEntry} from "./Dictionary";

const listenPath = "/Tag/{id}";
const dictionaryId = "Tag";

export const Tag_onCreate = functions.firestore.document(listenPath).onCreate(async (snapshot, context) => {
    const id = context.params.id;
    const map = snapshot.data();
    const obj = fromIdAndMap(id, map);

    await updateEntry(dictionaryId, fromIdAndMap, toSaveMap, obj);
});

export const Tag_onUpdate = functions.firestore.document(listenPath).onUpdate(async (change, context) => {
    const id = context.params.id;
    const map = change.after.data();
    const obj = fromIdAndMap(id, map);

    await updateEntry(dictionaryId, fromIdAndMap, toSaveMap, obj);
});

export const Tag_onDelete = functions.firestore.document(listenPath).onDelete(async (snapshot, context) => {
    const id = context.params.id;

    await deleteEntry(dictionaryId, fromIdAndMap, toSaveMap, id);
});

export async function getTagById(id: string): Promise<Tag | undefined> {
    const doc = await admin.firestore().doc(`Tag/${id}`).get();
    const map = doc.data();

    if (map === undefined) return undefined;

    return fromIdAndMap(doc.id, map);
}

export async function createTagById(id: string): Promise<void> {
    const docRef = await admin.firestore().doc(`Tag/${id}`);
    const map = {
        fixMe: true, // New docs require interference to manually set title.
    };

    await docRef.create(map);
}
