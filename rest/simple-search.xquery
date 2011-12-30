xquery version "1.0";

import module namespace ddi = "http://dda.dk/ddi" at "xmldb:exist:///db/dda/lib/search.xquery";

declare function local:main() as node()? {
    let $simple-search-parameters := request:get-data()/*
    return ddi:simpleSearch($simple-search-parameters)
};

local:main()