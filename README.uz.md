# claude-next

[English](README.md) · **O'zbekcha**

Claude Code'ni ikkita akkaunt bilan ishlating (masalan, ish va shaxsiy). Ular orasida bitta buyruq bilan almashasiz, suhbat yo'qolmaydi.

- `claude`: 1-akkaunt (oddiy `~/.claude`)
- `claude2`: 2-akkaunt (`~/.claude-2`)
- `claude-next`: boshqa akkauntga o'tadi va shu papkadagi **oxirgi suhbatni davom ettiradi**

Ikkala profil umumiy narsalarni symlink orqali bo'lishadi: `CLAUDE.md`, sozlamalar, skill'lar, agentlar, hook'lar, plaginlar, xotira va tarix. Faqat login alohida.

## O'rnatish

macOS yoki Linux kerak. Claude Code va `python3` o'rnatilgan bo'lsin.

```bash
curl -fsSL https://raw.githubusercontent.com/Shohruxbek2202/claude-next/main/install.sh | bash
```

yoki

```bash
git clone https://github.com/Shohruxbek2202/claude-next && cd claude-next && ./install.sh
```

Keyin 2-akkauntga bir marta kiring:

```bash
claude2        # ichida /login, 2-akkaunt bilan
```

Agar `~/.local/bin` `PATH` ichida bo'lmasa, `~/.zshrc` (yoki `~/.bashrc`) fayliga shu qatorni qo'shing: `export PATH="$HOME/.local/bin:$PATH"`.

## Ishlatish

1. Odatdagidek `claude` bilan ishlang.
2. Akkaunt almashtirmoqchi bo'lsangiz (masalan, limit tugadi), Claude'dan chiqing (`Ctrl+C` ni 2 marta bosing).
3. **O'sha papkaning o'zida**, oddiy terminalda yozing:

```bash
claude-next
```

U boshqa profilga o'tadi va suhbatni davom ettiradi. Kontekst 50 000 tokendan katta bo'lsa, avval `/compact` qiladi. Sababi: yangi akkauntda kesh yo'q, katta tarix uning limitini tez yeb qo'yadi.

Orqaga qaytish uchun yana `claude-next` deb yozing.

| Buyruq | Nima qiladi |
|---|---|
| `claude-next` | akkaunt almashtiradi va suhbatni davom ettiradi |
| `CLAUDE_NEXT_LIMIT=100000 claude-next` | avto-compact chegarasini o'zgartiradi |
| `echo 2 > ~/.claude-profile` | "hozir 2-profildaman" deb belgilaydi (keyingi o'tish 1-profilga bo'ladi) |
| `claude2 mcp add ...` | keyin qo'shiladigan MCP serverlarni ikkala profilga ham qo'shing |

Claude ichida `!claude-next` deb yozmang. U haqiqiy terminalni talab qiladi, aks holda ishlamaydi.

## Qanday ishlaydi

- `claude2` aslida `CLAUDE_CONFIG_DIR=~/.claude-2 claude` degani.
- Installer umumiy narsalarni `~/.claude` dan `~/.claude-2` ga symlink qiladi. `~/.claude.json` (MCP serverlar, sozlamalar) faylini akkaunt ma'lumotlarisiz nusxalaydi.
- `~/.claude-profile` fayli qaysi profilda ekaningizni eslab qoladi.
- Ikkala profil suhbatlarni bitta `projects` papkasiga yozadi, shuning uchun `--continue` aynan o'sha suhbatni topadi.

## O'chirish

```bash
rm -rf ~/.claude-2 ~/.claude-profile ~/.local/bin/claude2 ~/.local/bin/claude-next
```

## Eslatma

Anthropic [shartlariga](https://www.anthropic.com/legal/consumer-terms) amal qiling. O'zingizga tegishli akkauntlardan foydalaning va limitlarni shartlar ruxsat bermagan yo'l bilan aylanib o'tmang.
