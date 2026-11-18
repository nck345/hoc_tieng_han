const fs = require('fs');
const zlib = require('zlib');

const buf = fs.readFileSync('F:\\ewha\\tiếng hàn\\Chức năng đề thi\\Đề thi thật\\Kỳ thi số 96\\TOPIK 96 Level II Đọc_읽기_onthitopik.com.pdf');
let idx = 0;
let streams = [];
while (true) {
    let sIdx = buf.indexOf(Buffer.from('stream'), idx);
    if (sIdx === -1) break;
    let dataStart = sIdx + 6;
    if (buf[dataStart] === 0x0d) dataStart++;
    if (buf[dataStart] === 0x0a) dataStart++;
    let eIdx = buf.indexOf(Buffer.from('endstream'), dataStart);
    if (eIdx === -1) break;
    let streamData = buf.subarray(dataStart, eIdx);
    idx = eIdx + 9;
    try {
        let decomp = zlib.inflateSync(streamData);
        streams.push(decomp);
    } catch(e) {}
}
console.log('Decompressed streams:', streams.length);
for (let i = 0; i < Math.min(5, streams.length); i++) {
    console.log(`Stream ${i} (len ${streams[i].length}):`, streams[i].slice(0, 150).toString('latin1'));
}
