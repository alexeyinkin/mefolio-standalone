import {DictionaryEntry} from "./DictionaryEntry";
import {StringObject} from "./maps";
import {DictionaryEntryDenormalizer} from "./DictionaryEntryDenormalizer";
import {DictionaryEntryNormalizer} from "./DictionaryEntryNormalizer";

export type DictionaryEntries<T extends DictionaryEntry> = {[key: string]: T};

export function fromMap<T extends DictionaryEntry>(map: StringObject, entryFactory: DictionaryEntryDenormalizer<T>): DictionaryEntries<T> {
    const result = {} as DictionaryEntries<T>;

    for (const id in map) {
        result[id] = entryFactory(id, map[id]);
    }

    return result;
}

export function toSaveMap<T extends DictionaryEntry>(entries: DictionaryEntries<T>, entryNormalizer: DictionaryEntryNormalizer<T>): StringObject {
    const result = {} as StringObject;

    for (const id in entries) {
        result[id] = entryNormalizer(entries[id]);
    }

    return result;
}
