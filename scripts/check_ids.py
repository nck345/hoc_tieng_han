import re, sys
sys.stdout.reconfigure(encoding='utf-8')
html = open('index.html', 'r', encoding='utf-8').read()
ids = set(re.findall(r'id=["\']([^"\']+)["\']', html))
required = [
	'brand-home', 'tab-vocab', 'tab-exam', 'tab-communication', 'tab-notebook', 'tab-birds',
	'stat-learned-count', 'stat-bird-count', 'stat-nav-nb-count',
	'btn-home-vocab', 'btn-home-exam', 'btn-home-communication', 'btn-home-notebook',
	'view-home', 'view-units', 'view-study', 'view-exam', 'view-communication', 'view-notebook', 'view-birds',
	'study-collocations-grid', 'study-ordered-tokens-row', 'study-scramble-translation', 'study-scramble-input',
	'btn-check-scramble', 'btn-fill-scramble', 'study-scramble-feedback', 'btn-study-star',
	'btn-exam-subnav-folders', 'btn-exam-subnav-packs', 'exam-folders-container', 'exam-folder-detail-wrap',
	'btn-exam-folder-back', 'exam-folder-detail-title', 'exam-folder-items-grid', 'exam-packs-container',
	'exam-active-player', 'btn-exam-player-back', 'exam-player-type-badge', 'exam-player-progress-badge',
	'exam-player-timer', 'exam-q-instruction', 'exam-q-audio-box', 'btn-exam-audio-play', 'exam-audio-status',
	'btn-exam-speed-1', 'btn-exam-speed-slow', 'exam-q-passage', 'exam-q-options-list', 'btn-exam-submit-ans',
	'exam-solution-panel', 'exam-bird-feedback', 'exam-bird-img', 'exam-bird-title', 'exam-bird-desc',
	'exam-answer-type-note', 'exam-explanation-text', 'exam-transcript-section', 'exam-transcript-box',
	'exam-grammar-section', 'exam-grammar-list', 'exam-vocab-section', 'exam-vocab-grid', 'btn-exam-prev-q', 'btn-exam-next-q',
	'btn-comm-beginner', 'btn-comm-intermediate', 'comm-topic-pills', 'comm-card-topic-tag', 'comm-card-sentence-idx',
	'comm-speaker-tag', 'comm-interactive-korean', 'comm-romaja-text', 'comm-vietnamese-text',
	'btn-comm-audio-normal', 'btn-comm-audio-slow', 'btn-comm-mic', 'comm-user-audio-wrap', 'btn-comm-play-user',
	'comm-rec-status', 'comm-accuracy-badge-wrap', 'comm-accuracy-badge', 'comm-accuracy-val', 'btn-comm-prev', 'btn-comm-next',
	'nb-filter-pills', 'nb-count-all', 'notebook-items-grid', 'birds-gallery-grid',
	'bird-reward-modal', 'modal-reward-bird-icon-wrap', 'modal-reward-bird-name', 'modal-reward-bird-desc',
	'btn-close-bird-modal', 'btn-view-bird-collection'
]
missing = [i for i in required if i not in ids]
print("Missing IDs:", missing)
print("All present:", len(missing) == 0)

