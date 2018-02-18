module.exports = function(str, pattern) {
    const keys = pattern.match(/\$\{(.*?)\}/gi);

    const intersections = [];
    let position = 0;

    for (let key of keys) {
        let intersection = pattern.slice(position, pattern.indexOf(key));
        if (intersection.length>0) intersections.push(intersection);
        position += (key.length + intersection.length);
    }
    let lastIntersection = pattern.slice(position, pattern.length);
    if (lastIntersection.length>0) intersections.push(lastIntersection);

    let text = str;
    let response = {};
    let pieceIndex = 0;
    for (let intersection of intersections) {
        let tmp = text.split(intersection);
        let tag = keys[pieceIndex].match(/.*\$\{(.*)\}.*/)[1]; // [ '${action}', 'action', index: 0, input: '${action}' ]
        if (tmp[0].length>0) {
            response[tag] = tmp[0];
            text = tmp[1];
            pieceIndex++;
        } else {
            text = tmp[1];
        }
    }

    if (text){
        let tag = keys[pieceIndex].match(/.*\$\{(.*)\}.*/)[1]; // [ '${action}', 'action', index: 0, input: '${action}' ]
        response[tag] = text;
    }
    return response;
}