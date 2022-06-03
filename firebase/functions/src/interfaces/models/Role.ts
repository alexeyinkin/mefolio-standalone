import {StringObject} from "../maps";
import {DictionaryEntry, toSaveMap as entryToSaveMap} from "./DictionaryEntry";

export interface Role extends DictionaryEntry {
}

export function fromIdAndMap(id: string, map: StringObject): Role {
    const result = map as Role;

    result.id = id;
    result.title = map['title'] || id;

    return result;
}

export function toSaveMap(tag: Role): StringObject {
    const result = entryToSaveMap(tag);
    return result;
}
