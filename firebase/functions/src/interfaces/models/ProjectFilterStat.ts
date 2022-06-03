import {ProjectFilter} from "../filters/ProjectFilter";
import {StringObject} from "../maps";

export interface ProjectFilterStat {
    id: string;
    filter: ProjectFilter;
    count: number;
    tagsAnd: ProjectFilterStatLeafObject;
    year: ProjectFilterStatLeafObject;
}

interface ProjectFilterStatLeaf {
    count: number;
}

type ProjectFilterStatLeafObject = {[key: string]: ProjectFilterStatLeaf};


export function getEmpty(id: string, filter: ProjectFilter): ProjectFilterStat {
    return {
        id: id,
        filter: filter,
        count: 0,
        tagsAnd: {},
        year: {},
    };
}

export function toSaveMap(stat: ProjectFilterStat): StringObject {
    return {
        count: stat.count,
        tagsAnd: stat.tagsAnd,
        year: stat.year,
    };
}
