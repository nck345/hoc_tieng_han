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
        let s = decomp.toString('latin1');
        if (s.includes('BT')) {
            console.log('Stream has BT, length:', s.length);
            // Print text showing operators Tj, TJ
            let tjMatches = s.match(/\((.*?)\)\s*Tj/g) || s.match(/\[(.*?)\]\s*TJ/g);
            if (tjMatches) {
                console.log('Sample text operators:', tjMatches.slice(0, 10));
            }
        }
    } catch(e) {}
}
