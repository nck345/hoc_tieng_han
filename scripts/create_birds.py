import os

birds = {
    'bird-happy.svg': '''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 160 160" width="160" height="160">
  <defs>
    <radialGradient id="bg-glow" cx="50%" cy="50%" r="50%"><stop offset="0%" stop-color="#fef08a" stop-opacity="0.6"/><stop offset="100%" stop-color="#fef08a" stop-opacity="0"/></radialGradient>
    <linearGradient id="body-grad" x1="0%" y1="0%" x2="100%" y2="100%"><stop offset="0%" stop-color="#38bdf8"/><stop offset="100%" stop-color="#0284c7"/></linearGradient>
    <linearGradient id="wing-grad" x1="0%" y1="0%" x2="100%" y2="100%"><stop offset="0%" stop-color="#0ea5e9"/><stop offset="100%" stop-color="#0369a1"/></linearGradient>
  </defs>
  <circle cx="80" cy="80" r="70" fill="url(#bg-glow)"/>
  <polygon points="30,40 33,30 36,40 46,43 36,46 33,56 30,46 20,43" fill="#f59e0b"/>
  <polygon points="130,35 132,27 134,35 142,37 134,39 132,47 130,39 122,37" fill="#f59e0b"/>
  <line x1="65" y1="128" x2="60" y2="142" stroke="#f97316" stroke-width="4" stroke-linecap="round"/>
  <line x1="60" y1="142" x2="52" y2="144" stroke="#f97316" stroke-width="4" stroke-linecap="round"/>
  <line x1="60" y1="142" x2="64" y2="144" stroke="#f97316" stroke-width="4" stroke-linecap="round"/>
  <line x1="95" y1="128" x2="100" y2="142" stroke="#f97316" stroke-width="4" stroke-linecap="round"/>
  <line x1="100" y1="142" x2="96" y2="144" stroke="#f97316" stroke-width="4" stroke-linecap="round"/>
  <line x1="100" y1="142" x2="108" y2="144" stroke="#f97316" stroke-width="4" stroke-linecap="round"/>
  <ellipse cx="80" cy="85" rx="45" ry="42" fill="url(#body-grad)"/>
  <ellipse cx="80" cy="96" rx="28" ry="24" fill="#e0f2fe"/>
  <path d="M40,82 C20,60 15,35 30,30 C45,25 50,55 45,75 Z" fill="url(#wing-grad)"/>
  <path d="M120,82 C140,60 145,35 130,30 C115,25 110,55 115,75 Z" fill="url(#wing-grad)"/>
  <ellipse cx="68" cy="72" rx="7" ry="9" fill="#0f172a"/>
  <circle cx="66" cy="69" r="3" fill="#ffffff"/>
  <ellipse cx="92" cy="72" rx="7" ry="9" fill="#0f172a"/>
  <circle cx="90" cy="69" r="3" fill="#ffffff"/>
  <ellipse cx="56" cy="85" rx="6" ry="4" fill="#f43f5e" opacity="0.5"/>
  <ellipse cx="104" cy="85" rx="6" ry="4" fill="#f43f5e" opacity="0.5"/>
  <path d="M74,78 Q80,72 86,78 Q80,90 74,78 Z" fill="#f59e0b"/>
  <polygon points="80,20 65,55 95,55" fill="#ec4899"/>
  <circle cx="80" cy="18" r="5" fill="#fbbf24"/>
  <line x1="70" y1="35" x2="90" y2="35" stroke="#ffffff" stroke-width="3" stroke-linecap="round"/>
  <line x1="67" y1="45" x2="93" y2="45" stroke="#38bdf8" stroke-width="3" stroke-linecap="round"/>
</svg>''',

    'bird-genius.svg': '''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 160 160" width="160" height="160">
  <defs>
    <radialGradient id="bg-owl" cx="50%" cy="50%" r="50%"><stop offset="0%" stop-color="#818cf8" stop-opacity="0.4"/><stop offset="100%" stop-color="#818cf8" stop-opacity="0"/></radialGradient>
    <linearGradient id="owl-grad" x1="0%" y1="0%" x2="100%" y2="100%"><stop offset="0%" stop-color="#6366f1"/><stop offset="100%" stop-color="#4338ca"/></linearGradient>
  </defs>
  <circle cx="80" cy="80" r="70" fill="url(#bg-owl)"/>
  <ellipse cx="68" cy="136" rx="10" ry="5" fill="#f59e0b"/>
  <ellipse cx="92" cy="136" rx="10" ry="5" fill="#f59e0b"/>
  <ellipse cx="80" cy="90" rx="44" ry="42" fill="url(#owl-grad)"/>
  <ellipse cx="80" cy="102" rx="28" ry="26" fill="#ede9fe"/>
  <path d="M40,90 Q30,110 50,115" fill="none" stroke="#4f46e5" stroke-width="12" stroke-linecap="round"/>
  <path d="M120,90 Q135,100 120,115" fill="none" stroke="#4f46e5" stroke-width="12" stroke-linecap="round"/>
  <circle cx="66" cy="78" r="14" fill="#ffffff" stroke="#f59e0b" stroke-width="4"/>
  <circle cx="94" cy="78" r="14" fill="#ffffff" stroke="#f59e0b" stroke-width="4"/>
  <line x1="78" y1="78" x2="82" y2="78" stroke="#f59e0b" stroke-width="4"/>
  <circle cx="66" cy="78" r="5" fill="#1e1b4b"/>
  <circle cx="94" cy="78" r="5" fill="#1e1b4b"/>
  <polygon points="76,86 84,86 80,95" fill="#f59e0b"/>
  <polygon points="80,30 35,50 80,62 125,50" fill="#0f172a"/>
  <rect x="65" y="55" width="30" height="12" fill="#1e293b" rx="3"/>
  <line x1="115" y1="52" x2="125" y2="75" stroke="#fbbf24" stroke-width="3" stroke-linecap="round"/>
  <circle cx="125" cy="77" r="4" fill="#fbbf24"/>
</svg>''',

    'bird-cry.svg': '''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 160 160" width="160" height="160">
  <defs>
    <radialGradient id="bg-cry" cx="50%" cy="50%" r="50%"><stop offset="0%" stop-color="#cbd5e1" stop-opacity="0.4"/><stop offset="100%" stop-color="#cbd5e1" stop-opacity="0"/></radialGradient>
    <linearGradient id="cry-body" x1="0%" y1="0%" x2="100%" y2="100%"><stop offset="0%" stop-color="#94a3b8"/><stop offset="100%" stop-color="#64748b"/></linearGradient>
  </defs>
  <circle cx="80" cy="80" r="70" fill="url(#bg-cry)"/>
  <ellipse cx="68" cy="136" rx="10" ry="4" fill="#f97316"/>
  <ellipse cx="92" cy="136" rx="10" ry="4" fill="#f97316"/>
  <ellipse cx="80" cy="96" rx="44" ry="40" fill="url(#cry-body)"/>
  <ellipse cx="80" cy="106" rx="28" ry="22" fill="#f1f5f9"/>
  <ellipse cx="38" cy="105" rx="8" ry="20" fill="#475569" transform="rotate(15 38 105)"/>
  <ellipse cx="122" cy="105" rx="8" ry="20" fill="#475569" transform="rotate(-15 122 105)"/>
  <path d="M58,82 Q68,74 74,84" fill="none" stroke="#1e293b" stroke-width="4" stroke-linecap="round"/>
  <path d="M86,84 Q92,74 102,82" fill="none" stroke="#1e293b" stroke-width="4" stroke-linecap="round"/>
  <path d="M60,86 C50,96 52,118 62,118 C72,118 70,96 60,86 Z" fill="#38bdf8" opacity="0.9"/>
  <path d="M100,86 C90,96 92,118 102,118 C112,118 110,96 100,86 Z" fill="#38bdf8" opacity="0.9"/>
  <ellipse cx="62" cy="108" rx="2" ry="5" fill="#ffffff" opacity="0.8"/>
  <ellipse cx="102" cy="108" rx="2" ry="5" fill="#ffffff" opacity="0.8"/>
  <ellipse cx="80" cy="92" rx="8" ry="6" fill="#0f172a"/>
  <path d="M74,88 Q80,82 86,88" fill="#f59e0b" stroke="#f59e0b" stroke-width="2"/>
  <ellipse cx="80" cy="42" rx="26" ry="14" fill="#64748b" opacity="0.8"/>
  <circle cx="66" cy="38" r="12" fill="#64748b" opacity="0.8"/>
  <circle cx="94" cy="38" r="12" fill="#64748b" opacity="0.8"/>
  <line x1="70" y1="55" x2="66" y2="65" stroke="#38bdf8" stroke-width="2" stroke-dasharray="2,3"/>
  <line x1="80" y1="55" x2="76" y2="67" stroke="#38bdf8" stroke-width="2" stroke-dasharray="2,3"/>
  <line x1="90" y1="55" x2="86" y2="65" stroke="#38bdf8" stroke-width="2" stroke-dasharray="2,3"/>
</svg>''',

    'bird-sweeping.svg': '''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 160 160" width="160" height="160">
  <defs>
    <radialGradient id="bg-sweep" cx="50%" cy="50%" r="50%"><stop offset="0%" stop-color="#fed7aa" stop-opacity="0.4"/><stop offset="100%" stop-color="#fed7aa" stop-opacity="0"/></radialGradient>
    <linearGradient id="sw-body" x1="0%" y1="0%" x2="100%" y2="100%"><stop offset="0%" stop-color="#f97316"/><stop offset="100%" stop-color="#c2410c"/></linearGradient>
  </defs>
  <circle cx="80" cy="80" r="70" fill="url(#bg-sweep)"/>
  <ellipse cx="62" cy="138" rx="8" ry="4" fill="#b45309"/>
  <ellipse cx="84" cy="138" rx="8" ry="4" fill="#b45309"/>
  <ellipse cx="72" cy="92" rx="38" ry="36" fill="url(#sw-body)"/>
  <ellipse cx="68" cy="100" rx="22" ry="22" fill="#ffedd5"/>
  <circle cx="62" cy="78" r="5" fill="#1e293b"/>
  <circle cx="80" cy="78" r="5" fill="#1e293b"/>
  <path d="M92,68 C90,72 88,78 92,80 C95,80 97,76 92,68 Z" fill="#0284c7"/>
  <polygon points="68,84 76,84 72,92" fill="#fbbf24"/>
  <line x1="100" y1="60" x2="130" y2="135" stroke="#78350f" stroke-width="5" stroke-linecap="round"/>
  <polygon points="126,125 142,138 120,146" fill="#f59e0b" stroke="#d97706" stroke-width="2"/>
  <ellipse cx="138" cy="142" rx="6" ry="3" fill="#e2e8f0" opacity="0.7"/>
  <ellipse cx="146" cy="138" rx="4" ry="2" fill="#e2e8f0" opacity="0.7"/>
  <rect x="50" y="46" width="46" height="12" fill="#ef4444" rx="3"/>
  <text x="73" y="56" font-size="9" font-weight="bold" fill="#ffffff" text-anchor="middle" font-family="sans-serif">PHẠT</text>
</svg>''',

    'bird-phoenix.svg': '''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 160 160" width="160" height="160">
  <defs>
    <radialGradient id="bg-gold" cx="50%" cy="50%" r="50%"><stop offset="0%" stop-color="#fde047" stop-opacity="0.7"/><stop offset="100%" stop-color="#eab308" stop-opacity="0"/></radialGradient>
    <linearGradient id="phoenix-grad" x1="0%" y1="0%" x2="100%" y2="100%"><stop offset="0%" stop-color="#f59e0b"/><stop offset="50%" stop-color="#ef4444"/><stop offset="100%" stop-color="#b91c1c"/></linearGradient>
  </defs>
  <circle cx="80" cy="80" r="75" fill="url(#bg-gold)"/>
  <path d="M80,18 L72,42 L80,36 L88,42 Z" fill="#f59e0b"/>
  <path d="M68,26 L64,48 L73,42 Z" fill="#ef4444"/>
  <path d="M92,26 L96,48 L87,42 Z" fill="#ef4444"/>
  <path d="M40,80 C10,50 10,20 35,25 C55,30 55,65 50,85 Z" fill="url(#phoenix-grad)"/>
  <path d="M120,80 C150,50 150,20 125,25 C105,30 105,65 110,85 Z" fill="url(#phoenix-grad)"/>
  <ellipse cx="80" cy="86" rx="40" ry="42" fill="url(#phoenix-grad)"/>
  <ellipse cx="80" cy="96" rx="24" ry="26" fill="#fef08a"/>
  <ellipse cx="68" cy="74" rx="6" ry="8" fill="#18181b"/>
  <circle cx="67" cy="72" r="2.5" fill="#ffffff"/>
  <ellipse cx="92" cy="74" rx="6" ry="8" fill="#18181b"/>
  <circle cx="91" cy="72" r="2.5" fill="#ffffff"/>
  <polygon points="75,80 85,80 80,94" fill="#fbbf24" stroke="#d97706" stroke-width="1"/>
  <circle cx="80" cy="102" r="8" fill="#fbbf24" stroke="#b45309" stroke-width="2"/>
  <text x="80" y="106" font-size="9" font-weight="bold" fill="#78350f" text-anchor="middle" font-family="sans-serif">★</text>
  <path d="M74,128 C68,148 60,155 70,158 C78,160 76,145 80,132 Z" fill="#f97316"/>
  <path d="M86,128 C92,148 100,155 90,158 C82,160 84,145 80,132 Z" fill="#ef4444"/>
</svg>''',

    'bird-cyber.svg': '''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 160 160" width="160" height="160">
  <defs>
    <radialGradient id="bg-cyber" cx="50%" cy="50%" r="50%"><stop offset="0%" stop-color="#06b6d4" stop-opacity="0.5"/><stop offset="100%" stop-color="#06b6d4" stop-opacity="0"/></radialGradient>
    <linearGradient id="cy-grad" x1="0%" y1="0%" x2="100%" y2="100%"><stop offset="0%" stop-color="#06b6d4"/><stop offset="100%" stop-color="#3b82f6"/></linearGradient>
  </defs>
  <circle cx="80" cy="80" r="75" fill="url(#bg-cyber)"/>
  <polygon points="40,80 15,45 50,60" fill="#3b82f6"/>
  <polygon points="120,80 145,45 110,60" fill="#3b82f6"/>
  <polygon points="80,45 115,85 80,135 45,85" fill="url(#cy-grad)"/>
  <polygon points="80,60 100,85 80,118 60,85" fill="#0f172a"/>
  <line x1="60" y1="78" x2="100" y2="78" stroke="#22d3ee" stroke-width="4"/>
  <circle cx="70" cy="78" r="4" fill="#a5f3fc"/>
  <circle cx="90" cy="78" r="4" fill="#a5f3fc"/>
  <polygon points="76,86 84,86 80,95" fill="#f59e0b"/>
  <circle cx="80" cy="105" r="5" fill="#22d3ee"/>
</svg>'''
}

os.makedirs('assets/birds', exist_ok=True)
for fname, content in birds.items():
    with open(os.path.join('assets/birds', fname), 'w', encoding='utf-8') as f:
        f.write(content.strip())
    print(f'Wrote assets/birds/{fname}')

