from pathlib import Path
import sys

if len(sys.argv) < 4:
	print("Usage: mimetypes_parser.py target_file output_file source_file")
	sys.exit(1)

target_file_path = Path(sys.argv[1])
output_file_path = Path(sys.argv[2])
src_file_path = Path(sys.argv[3])

mime_map = {}
added_map = {}

if target_file_path.exists():
	with open(target_file_path, "r") as f:
		for line in f:
			line = line.strip()
			if not line or "=" not in line:
				continue
			mime, desktop = line.split("=", 1)
			mime_map[mime.strip()] = desktop.strip()

with open(src_file_path, "r") as f:
	for desktop_path_line in f:
		desktop_path_line = desktop_path_line.strip()
		if not desktop_path_line:
			continue
		desktop_path = Path(desktop_path_line)
		if not desktop_path.exists() or not desktop_path.is_file():
			continue
		desktop_basename = desktop_path.name
		with open(desktop_path, "r") as df:
			for line in df:
				line = line.strip()
				if line.startswith("MimeType="):
					mime_str = line[len("MimeType="):]
					for m in mime_str.split(";"):
						mt = m.strip()
						if mt:
							if mt in mime_map:
								if mime_map[mt] != desktop_basename:
									if mt not in added_map:
										added_map[mt] = set()
									added_map[mt].add(desktop_basename)
							else:
								mime_map[mt] = desktop_basename

with open(output_file_path, "w") as out:
	out.write("[Default Applications]\n")
	for mime, desktop in mime_map.items():
		out.write(f"{mime}={desktop}\n")
	out.write("\n[Added Associations]\n")
	for mime, desktops in added_map.items():
		for desktop in desktops:
			out.write(f"{mime}={desktop}\n")
