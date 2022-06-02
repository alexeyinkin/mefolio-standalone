import {DictionaryEntry} from "./DictionaryEntry";
import {DictionaryEntries, fromMap as entriesFromMap, toSaveMap as entriesToSaveMap} from "./DictionaryEntries";
import {StringObject} from "../maps";
import {DictionaryEntryDenormalizer} from "../DictionaryEntryDenormalizer";
import {DictionaryEntryNormalizer} from "../DictionaryEntryNormalizer";

export interface Dictionary<T extends DictionaryEntry> {
    id: string;
    entries: DictionaryEntries<T>;
}

export function getEmpty<T extends DictionaryEntry>(id: string): Dictionary<T> {
    return {
        id: id,
        entries: {},
    };
}

export function fromIdAndMap<T extends DictionaryEntry>(id: string, map: StringObject, entryDenormalizer: DictionaryEntryDenormalizer<T>): Dictionary<T> {
    return {
        id: id,
        entries: entriesFromMap<T>(map["entries"], entryDenormalizer),
    };
}

export function toSaveMap<T extends DictionaryEntry>(dictionary: Dictionary<T>, entryNormalizer: DictionaryEntryNormalizer<T>): StringObject {
    return {
        entries: entriesToSaveMap(dictionary.entries, entryNormalizer),
    }
}
