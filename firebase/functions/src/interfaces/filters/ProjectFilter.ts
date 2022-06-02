export interface ProjectFilter {
    tagsAnd: string[],
    year: number | undefined,
}

export function getEmpty(): ProjectFilter {
    return {
        tagsAnd: [],
        year: undefined,
    };
}

export function and(a: ProjectFilter, b: ProjectFilter): ProjectFilter {
    if (conflictAnd(a, b)) {
        throw "Conflicting filters";
    }

    const tagsAnd = Array.from<string>(new Set<string>([...a.tagsAnd, ...b.tagsAnd])).sort();

    return {
        tagsAnd: tagsAnd,
        year: a.year || b.year,
    };
}

function conflictAnd(a: ProjectFilter, b: ProjectFilter): boolean {
    return conflictAndYear(a, b);
}

function conflictAndYear(a: ProjectFilter, b: ProjectFilter): boolean {
    if (a.year === undefined) return false;
    if (b.year === undefined) return false;
    return a.year !== b.year;
}

export function getId(filter: ProjectFilter): string {
    const parts = new Array<string>();

    parts.push(...filter.tagsAnd.map(tag => `t${tag}`));

    const year = filter.year;
    if (year !== undefined) {
        parts.push(`y${year}`);
    }

    return `f_${parts.join('_')}`;
}
