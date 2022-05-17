import {StringMap} from "./StringMap";
import {Url} from "./Url";
import {firestore} from "firebase-admin";
import Timestamp = firestore.Timestamp;

export interface Project {
    body: string | undefined;
    dateTime: Date | undefined;
    description: string;
    imageUrl: string;
    keywords: string[];
    tags: string[];
    title: string;
    urls: Url[];
    year: number | undefined;
}

export function fromMap(map: StringMap): Project {
    const result = map as Project;

    result.dateTime = toDate(map['dateTime']);
    result.urls = result.urls ?? [];
    result.tags = result.tags ?? [];
    result.keywords = result.keywords ?? [];

    return result;
}

function toDate(value: any): Date | undefined {
    if (value instanceof Date) return value;
    if (value instanceof Timestamp) return value.toDate();
    if (typeof value === 'string') return new Date(value);

    return undefined;
}

export function getKeywords(obj: Project): string[] {
    const result: string[] = [];

    result.push(...getTagKeywords(obj.tags));

    return result;
}

function getTagKeywords(tags: string[]): string[] {
    return tags.map(tag => `tag_${tag}`);
}
