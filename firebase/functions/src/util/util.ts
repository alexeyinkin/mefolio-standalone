import * as admin from "firebase-admin";
import {firestore} from "firebase-admin";
import Timestamp = firestore.Timestamp;
import {StringMap} from "../interfaces/StringMap";

export async function fixDate(map: StringMap, fieldName: string, documentPath: string): Promise<void> {
    const value = map[fieldName];
    if (typeof value === 'string') {
        const set = new Map<string, any>();

        set.set(fieldName, Timestamp.fromDate(new Date(value)));
        await admin.firestore().doc(documentPath).update(Object.fromEntries(set));
    }
}
