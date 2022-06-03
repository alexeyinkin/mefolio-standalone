import * as admin from "firebase-admin";
import * as functions from "firebase-functions";

import {Role, fromIdAndMap, toSaveMap} from "../interfaces/models/Role";
import {deleteEntry, updateEntry} from "./Dictionary";

const listenPath = "/Role/{id}";
const dictionaryId = "Role";

export const Role_onCreate = functions.firestore.document(listenPath).onCreate(async (snapshot, context) => {
    const id = context.params.id;
    const map = snapshot.data();
    const obj = fromIdAndMap(id, map);

    await updateEntry(dictionaryId, fromIdAndMap, toSaveMap, obj);
});

export const Role_onUpdate = functions.firestore.document(listenPath).onUpdate(async (change, context) => {
    const id = context.params.id;
    const map = change.after.data();
    const obj = fromIdAndMap(id, map);

    await updateEntry(dictionaryId, fromIdAndMap, toSaveMap, obj);
});

export const Role_onDelete = functions.firestore.document(listenPath).onDelete(async (snapshot, context) => {
    const id = context.params.id;

    await deleteEntry(dictionaryId, fromIdAndMap, toSaveMap, id);
});

export async function getRoleById(id: string): Promise<Role | undefined> {
    const doc = await admin.firestore().doc(`Role/${id}`).get();
    const map = doc.data();

    if (map === undefined) return undefined;

    return fromIdAndMap(doc.id, map);
}

export async function createRoleById(id: string): Promise<void> {
    const docRef = await admin.firestore().doc(`Role/${id}`);
    const map = {
        fixMe: true, // New docs require interference to manually set title.
    };

    await docRef.create(map);
}
