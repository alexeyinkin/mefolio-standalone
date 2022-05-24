import {StringObject} from "./maps";
import {DictionaryEntry, toSaveMap as entryToSaveMap} from "./DictionaryEntry";

export interface Tag extends DictionaryEntry {
}

export function fromIdAndMap(id: string, map: StringObject): Tag {
    const result = map as Tag;

    result.id = id;
    result.title = map['title'] || id;

    return result;
}

export function toSaveMap(tag: Tag): StringObject {
    const result = entryToSaveMap(tag);
    return result;
}
