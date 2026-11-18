param(
    [string]$examId
)

# Standard Instructions
function Get-Instruction($q, $section) {
    if ($section -eq 'listening') {
        if ($q -le 3)  { return "※ [1~3] 다음을 듣고 알맞은 그림을 고르십시오. (각 2점)" }
        if ($q -le 8)  { return "※ [4~8] 다음 대화를 잘 듣고 이어질 수 있는 말을 고르십시오. (각 2점)" }
        if ($q -le 12) { return "※ [9~12] 다음 대화를 잘 듣고 여자가 이어서 할 행동으로 알맞은 것을 고르십시오. (각 2점)" }
        if ($q -le 16) { return "※ [13~16] 다음을 듣고 내용과 일치하는 것을 고르십시오. (각 2점)" }
        if ($q -le 20) { return "※ [17~20] 다음을 듣고 남자의 중심 생각을 고르십시오. (각 2점)" }
        if ($q -le 22) { return "※ [21~22] 다음을 듣고 물음에 답하십시오. (각 2점)" }
        if ($q -le 24) { return "※ [23~24] 다음을 듣고 물음에 답하십시오. (각 2점)" }
        if ($q -le 26) { return "※ [25~26] 다음을 듣고 물음에 답하십시오. (각 2점)" }
        if ($q -le 28) { return "※ [27~28] 다음을 듣고 물음에 답하십시오. (각 2점)" }
        if ($q -le 30) { return "※ [29~30] 다음을 듣고 물음에 답하십시오. (각 2점)" }
        if ($q -le 32) { return "※ [31~32] 다음을 듣고 물음에 답하십시오. (각 2점)" }
        if ($q -le 34) { return "※ [33~34] 다음을 듣고 물음에 답하십시오. (각 2점)" }
        if ($q -le 36) { return "※ [35~36] 다음을 듣고 물음에 답하십시오. (각 2점)" }
        if ($q -le 38) { return "※ [37~38] 다음은 교양 프로그램입니다. 잘 듣고 물음에 답하십시오. (각 2점)" }
        if ($q -le 40) { return "※ [39~40] 다음은 대담입니다. 잘 듣고 물음에 답하십시오. (각 2점)" }
        if ($q -le 42) { return "※ [41~42] 다음은 강연입니다. 잘 듣고 물음에 답하십시오. (각 2점)" }
        if ($q -le 44) { return "※ [43~44] 다음은 다큐멘터리입니다. 잘 듣고 물음에 답하십시오. (각 2점)" }
        if ($q -le 46) { return "※ [45~46] 다음은 강연입니다. 잘 듣고 물음에 답하십시오. (각 2점)" }
        if ($q -le 48) { return "※ [47~48] 다음은 대담입니다. 잘 듣고 물음에 답하십시오. (각 2점)" }
        return "※ [49~50] 다음은 강연입니다. 잘 듣고 물음에 답하십시오. (각 2점)"
    } else {
        if ($q -le 2)  { return "※ [1~2] ( )에 들어갈 가장 알맞은 것을 고르십시오. (각 2점)" }
        if ($q -le 4)  { return "※ [3~4] 다음 밑줄 친 부분과 의미가 비슷한 것을 고르십시오. (각 2점)" }
        if ($q -le 8)  { return "※ [5~8] 다음은 무엇에 대한 글인지 고르십시오. (각 2점)" }
        if ($q -le 12) { return "※ [9~12] 다음 글 또는 도표의 내용과 같은 것을 고르십시오. (각 2점)" }
        if ($q -le 15) { return "※ [13~15] 다음을 순서대로 맞게 배열한 것을 고르십시오. (각 2점)" }
        if ($q -le 18) { return "※ [16~18] 다음을 읽고 ( )에 들어갈 내용으로 가장 알맞은 것을 고르십시오. (각 2점)" }
        if ($q -le 20) { return "※ [19~20] 다음을 읽고 물음에 답하십시오. (각 2점)" }
        if ($q -le 22) { return "※ [21~22] 다음을 읽고 물음에 답하십시오. (각 2점)" }
        if ($q -le 24) { return "※ [23~24] 다음을 읽고 물음에 답하십시오. (각 2점)" }
        if ($q -le 27) { return "※ [25~27] 다음은 신문 기사의 제목입니다. 가장 잘 설명한 것을 고르십시오. (각 2점)" }
        if ($q -le 31) { return "※ [28~31] 다음을 읽고 ( )에 들어갈 내용으로 가장 알맞은 것을 고르십시오. (각 2점)" }
        if ($q -le 34) { return "※ [32~34] 다음을 읽고 내용이 같은 것을 고르십시오. (각 2점)" }
        if ($q -le 38) { return "※ [35~38] 다음 글의 주제로 가장 알맞은 것을 고르십시오. (각 2점)" }
        if ($q -le 41) { return "※ [39~41] 다음 글에서 <보기>의 문장이 들어가기에 가장 알맞은 곳을 고르십시오. (각 2점)" }
        if ($q -le 43) { return "※ [42~43] 다음을 읽고 물음에 답하십시오. (각 2점)" }
        if ($q -le 45) { return "※ [44~45] 다음을 읽고 물음에 답하십시오. (각 2점)" }
        if ($q -le 47) { return "※ [46~47] 다음을 읽고 물음에 답하십시오. (각 2점)" }
        return "※ [48~50] 다음을 읽고 물음에 답하십시오. (각 2점)"
    }
}

function Get-TypeId($q, $section) {
    if ($section -eq 'listening') {
        if ($q -le 3)  { return "L_TYPE_1" }
        if ($q -le 8)  { return "L_TYPE_2" }
        if ($q -le 12) { return "L_TYPE_3" }
        if ($q -le 16) { return "L_TYPE_4" }
        if ($q -le 20) { return "L_TYPE_5" }
        return "L_TYPE_6"
    } else {
        if ($q -le 2)  { return "R_TYPE_1" }
        if ($q -le 4)  { return "R_TYPE_2" }
        if ($q -le 8)  { return "R_TYPE_3" }
        if ($q -le 12) { return "R_TYPE_4" }
        if ($q -le 15) { return "R_TYPE_5" }
        if ($q -le 18) { return "R_TYPE_6" }
        return "R_TYPE_7"
    }
}

function Get-TypeName($q, $section) {
    if ($section -eq 'listening') {
        if ($q -le 3)  { return "Nghe: Chọn tranh hoặc biểu đồ thích hợp" }
        if ($q -le 8)  { return "Nghe: Chọn câu đối đáp tiếp theo" }
        if ($q -le 12) { return "Nghe: Chọn hành động tiếp theo của nhân vật" }
        if ($q -le 16) { return "Nghe: Chọn nội dung đồng nhất (đúng với bài nghe)" }
        if ($q -le 20) { return "Nghe: Chọn suy nghĩ trọng tâm của nhân vật" }
        return "Nghe: Đoạn văn dài (2 câu hỏi)"
    } else {
        if ($q -le 2)  { return "Đọc: Điền ngữ pháp & từ vựng vào chỗ trống" }
        if ($q -le 4)  { return "Đọc: Chọn ngữ pháp đồng nghĩa (tương đương)" }
        if ($q -le 8)  { return "Đọc: Đọc hiểu quảng cáo / áp phích / bảng hiệu" }
        if ($q -le 12) { return "Đọc: Đọc hiểu thông báo & biểu đồ" }
        if ($q -le 15) { return "Đọc: Sắp xếp thứ tự các câu thành đoạn văn" }
        if ($q -le 18) { return "Đọc: Điền câu vào chỗ trống trong đoạn văn" }
        return "Đọc hiểu chủ đề & bài viết dài"
    }
}

Write-Host "Helper functions loaded."
