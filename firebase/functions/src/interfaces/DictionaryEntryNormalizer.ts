import {DictionaryEntry} from "./models/DictionaryEntry";
import {StringObject} from "./maps";

export type DictionaryEntryNormalizer<T extends DictionaryEntry> = (entry: T) => StringObject;
