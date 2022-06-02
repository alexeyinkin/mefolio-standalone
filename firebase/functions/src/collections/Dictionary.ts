import * as admin from "firebase-admin";

import {Dictionary, getEmpty, fromIdAndMap, toSaveMap} from "../interfaces/models/Dictionary";
import {DictionaryEntry} from "../interfaces/models/DictionaryEntry";
import {DictionaryEntryDenormalizer} from "../interfaces/DictionaryEntryDenormalizer";
import {DictionaryEntryNormalizer} from "../interfaces/DictionaryEntryNormalizer";

import DocumentData = admin.firestore.DocumentData;
import DocumentReference = admin.firestore.DocumentReference;

export async function getById<T extends DictionaryEntry>(id: string, entryFactory: DictionaryEntryDenormalizer<T>): Promise<Dictionary<T> | undefined> {
    const doc = await getDocRef(id).get();
    const map = doc.data();

    if (map === undefined) return getEmpty(id);

    return fromIdAndMap(doc.id, map, entryFactory);
}

export async function updateEntry<T extends DictionaryEntry>(id: string, entryDenormalizer: DictionaryEntryDenormalizer<T>, entryNormalizer: DictionaryEntryNormalizer<T>, entry: T): Promise<void> {
    const dictionary = await getById<T>(id, entryDenormalizer) || getEmpty<T>(id);

    dictionary.entries[entry.id] = entry;
    await save(dictionary, entryNormalizer);
    console.log("saved");
}

export async function deleteEntry<T extends DictionaryEntry>(id: string, entryDenormalizer: DictionaryEntryDenormalizer<T>, entryNormalizer: DictionaryEntryNormalizer<T>, entryId: string): Promise<void> {
    const dictionary = await getById<T>(id, entryDenormalizer) || getEmpty<T>(id);

    delete dictionary.entries[entryId];
    await save(dictionary, entryNormalizer);
}

async function save<T extends DictionaryEntry>(dictionary: Dictionary<T>, entryNormalizer: DictionaryEntryNormalizer<T>): Promise<void> {
    const ref = getDocRef(dictionary.id);
    const set = toSaveMap(dictionary, entryNormalizer);
    await ref.set(set);
}

function getDocRef(id: string): DocumentReference<DocumentData> {
    return admin.firestore().doc(`Dictionary/${id}`);
}
