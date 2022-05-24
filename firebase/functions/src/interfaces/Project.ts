import {StringObject, StringBoolObject} from "./maps";
import {Url} from "./Url";
import {firestore} from "firebase-admin";
import Timestamp = firestore.Timestamp;

export interface Project {
    id: string;
    body: string | undefined;
    dateTime: Date | undefined;
    description: string;
    imageUrl: string;
    keywords: string[];
    tags: string[];
    tagsMap: Map<string, boolean>;
    title: string;
    urls: Url[];
    year: number | undefined;
}

export function fromIdAndMap(id: string, map: StringObject): Project {
    const result = map as Project;

    result.id = id;
    result.dateTime = toDate(map['dateTime']);
    result.keywords = result.keywords ?? [];
    result.tags = result.tags ?? [];
    result.tagsMap = new Map<string, boolean>(Object.entries(map['tagsMap'] ?? {}));
    result.urls = result.urls ?? [];

    return result;
}

function toDate(value: any): Date | undefined {
    if (value instanceof Date) return value;
    if (value instanceof Timestamp) return value.toDate();
    if (typeof value === 'string') return new Date(value);

    return undefined;
}

export function getProjectKeywords(obj: Project): string[] {
    const result: string[] = [];

    result.push(...getTagKeywords(obj.tags));

    return result;
}

function getTagKeywords(tags: string[]): string[] {
    return tags.map(tag => `tag_${tag}`);
}

export function getProjectTagsMap(obj: Project): StringBoolObject {
    const result = {} as StringBoolObject;

    for (const tag of obj.tags) {
        result[tag] = true;
    }

    return result;
}
