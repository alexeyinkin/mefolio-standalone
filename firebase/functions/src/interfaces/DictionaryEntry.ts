import {StringObject} from "./maps";

export interface DictionaryEntry {
    id: string;
    title: string;
}

export function fromIdAndMap(id: string, map: StringObject): DictionaryEntry {
    const result = map as DictionaryEntry;

    result.id = id;
    result.title = map['title'] || id;

    return result;
}

export function toSaveMap(entry: DictionaryEntry): StringObject {
    return {
        title: entry.title,
    };
}
