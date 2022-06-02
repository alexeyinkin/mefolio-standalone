import {StringObject} from "../maps";

export interface ProjectFilterStat {
    id: string;
    count: number;
}

export function getEmpty(id: string): ProjectFilterStat {
    return {
        id: id,
        count: 0,
    };
}

export function toSaveMap(stat: ProjectFilterStat): StringObject {
    return {
        count: stat.count,
    };
}
