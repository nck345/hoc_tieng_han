import json, os, sys, re
sys.stdout.reconfigure(encoding='utf-8')

with open('js/data.js', 'r', encoding='utf-8') as f:
    txt = f.read()

raw = txt.replace('window.TOPIC_UNITS=', '').rstrip(';\n')
units = json.loads(raw)

extra_collocations_pool = {
    '며느리': ['맏며느리', '며느리 사랑'],
    '새어머니': ['새어머니의 사랑', '새어머니와 살다'],
    '손자': ['손자를 안다', '첫 손자'],
    '시부모님': ['시부모님께 효도하다', '시부모님 댁'],
    '자녀': ['자녀를 양육하다', '자녀의 미래'],
    '현모양처': ['현모양처의 꿈', '이상적인 현모양처'],
    '효녀': ['소문난 효녀', '부모님의 효녀'],
    '막내': ['귀여운 막내', '막내 동생'],
    '맏딸': ['든든한 맏딸', '집안의 맏딸'],
    '쌍둥이': ['쌍둥이 자매', '쌍둥이 형제'],
    '외동딸': ['사랑받는 외동딸', '하나뿐인 외동딸'],
    '자매': ['다정한 자매', '자매 사이'],
    '가정': ['행복한 가정', '가정을 지키다'],
    '식구': ['대가족 식구', '새 식구'],
    '집안': ['화목한 집안', '집안일']
}

for u in units:
    for w in u['words']:
        ko = w['korean']
        colls = w.get('collocations', [])
        
        # Ensure 4 collocations
        if ko in extra_collocations_pool:
            for c in extra_collocations_pool[ko]:
                if c not in colls:
                    colls.append(c)
        
        # Generic natural additions if still < 4
        defaults = [
            f"{ko}의 특징",
            f"{ko}을/를 알다",
            f"좋은 {ko}",
            f"{ko}와/과 관련되다",
            f"{ko}에 대해 생각하다"
        ]
        for d in defaults:
            if len(colls) >= 4:
                break
            if d not in colls:
                colls.append(d)
        
        w['collocations'] = colls[:4]
        
        # Add ordered tokens from sample sentence
        s_sentence = w.get('sample_sentence', '')
        tokens = [t.strip() for t in s_sentence.split() if t.strip()]
        w['ordered_tokens'] = tokens

out_js = "window.TOPIC_UNITS = " + json.dumps(units, ensure_ascii=False, indent="\t") + ";\n"
with open('js/data.js', 'w', encoding='utf-8') as f:
    f.write(out_js)

print(f"Successfully enriched {len(units)} units with 4 collocations each and ordered sentence tokens.")

