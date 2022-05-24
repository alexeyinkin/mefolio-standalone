import {DictionaryEntry} from "./DictionaryEntry";
import {StringObject} from "./maps";

export type DictionaryEntryDenormalizer<T extends DictionaryEntry> = (id: string, map: StringObject) => T;
