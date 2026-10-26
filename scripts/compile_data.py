import json,sys,os
sys.stdout.reconfigure(encoding='utf-8')
import vocab_part1,vocab_part2,vocab_part3
all_raw=vocab_part1.units_raw+vocab_part2.units_raw+vocab_part3.units_raw
units=[]
total_words=0
for idx,item in enumerate(all_raw,1):
	day_num,t_ko,t_vi,cat,words_raw=item
	u_id=f"unit_{idx}"
	words=[]
	for w_idx,w in enumerate(words_raw,1):
		korean,pos,pos_name,vietnamese,hanja,hints,s_ko,s_vi,collocs=w
		words.append({
			"id":f"u{idx}_w{w_idx}",
			"korean":korean,
			"pos":pos,
			"posName":pos_name,
			"vietnamese":vietnamese,
			"hanja":hanja,
			"hint_words":hints,
			"sample_sentence":s_ko,
			"sample_translation":s_vi,
			"collocations":collocs
		})
		total_words+=1
	units.append({
		"id":u_id,
		"day":day_num,
		"unitNumber":idx,
		"titleKo":t_ko,
		"titleVi":t_vi,
		"category":cat,
		"wordCount":len(words),
		"words":words
	})
out_path=os.path.join("js","data.js")
js_content="window.TOPIC_UNITS="+json.dumps(units,ensure_ascii=False,indent="\t")+";\n"
with open(out_path,"w",encoding="utf-8") as f:
	f.write(js_content)
print(f"Generated {len(units)} units with {total_words} words to {out_path}")
