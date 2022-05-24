import {DictionaryEntry} from "./DictionaryEntry";
import {StringObject} from "./maps";

export type DictionaryEntryNormalizer<T extends DictionaryEntry> = (entry: T) => StringObject;
