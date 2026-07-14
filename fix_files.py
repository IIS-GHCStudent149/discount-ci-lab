from pathlib import Path

for name in ["discount.py", "test_discount.py", "requirements.txt"]:
    path = Path(name)
    data = path.read_bytes()
    for encoding in ["utf-16", "utf-16-le", "utf-16-be"]:
        try:
            text = data.decode(encoding)
            path.write_text(text, encoding="utf-8")
            print(f"Converted {name} using {encoding}")
            break
        except UnicodeDecodeError:
            continue
    else:
        print(f"Could not decode {name}")
