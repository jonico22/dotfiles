# 9. IA local y conversión de archivos

Todo corre en el equipo (sin GPU dedicada: Ryzen 7 8840U, 28 GB de RAM), nada sale a internet.
Los modelos van con **Ollama**; los convertidores son programas normales, sin IA.

## Modelos locales (Ollama)

| Modelo | Tamaño | Para qué | Velocidad aprox. |
|---|---|---|---|
| `qwen2.5-coder:1.5b` | 1 GB | Autocompletar en el editor (el chat de código va por un modelo en la nube) | ~1 s por sugerencia |
| `glm-ocr` | 2,7 GB | OCR: leer el texto exacto de una imagen | ~7 s |
| `gemma4:e4b` | 6,6 GB | Describir imágenes y responder preguntas sobre ellas | ~10 s |
| `translategemma:12b` / `:4b` | 8,1 / 3,3 GB | Traducir (`traducir`, `tr4`) | — |

```bash
ollama run glm-ocr "Text Recognition: ./doc.png"  # OCR
ollama run gemma4:e4b "¿Qué hay en esta imagen? ./foto.jpg"
```

- Revisa siempre cifras, fechas e importes que lea un modelo. Para el texto exacto usa `glm-ocr`;
  `gemma4:e4b` interpreta y a veces inventa detalles.
- Para chat general y razonamiento difícil se usa un modelo de pago; los locales son para tareas
  puntuales o material privado.

## Convertir archivos

| Quiero... | Comando |
|---|---|
| Vídeo a MP4 / audio a MP3 | `ffmpeg -i entrada.mov salida.mp4`, `ffmpeg -i video.mp4 -vn audio.mp3` |
| Imagen a otro formato / redimensionar | `magick foto.png foto.webp`, `magick foto.jpg -resize 50% chica.jpg` |
| Word / Excel / PowerPoint a PDF | `soffice --headless --convert-to pdf archivo.docx` |
| Markdown a Word / HTML / PDF | `pandoc nota.md -o nota.docx` |
| Texto de un PDF | `pdftotext archivo.pdf -` |
| PDF complejo (tablas, columnas) a Markdown | `docling --to md --output salida/ archivo.pdf` |
| Word / Excel / PowerPoint / PDF a Markdown | `markitdown archivo.docx -o archivo.md` |
| PDF a imágenes | `pdftoppm -png archivo.pdf pagina` |
| Unir / dividir PDFs | `qpdf --empty --pages a.pdf b.pdf -- unido.pdf`, `qpdf entrada.pdf --pages . 1-3 -- parte.pdf` |
| Comprimir un PDF | `gs -sDEVICE=pdfwrite -dPDFSETTINGS=/ebook -o chico.pdf -dNOPAUSE -dBATCH grande.pdf` |
| PDF escaneado a PDF buscable (OCR) | `ocrmypdf -l spa escaneado.pdf buscable.pdf` |
| Ver / borrar metadatos de una foto | `exiftool foto.jpg`, `exiftool -all= foto.jpg` |
| Abrir ZIP, 7z, RAR | `7zz x archivo.7z`, `unar archivo.rar` |
| Descargar vídeo o audio | `yt-dlp URL`, `yt-dlp -x --audio-format mp3 URL` |

**Tablas en PDF:** `pdftotext -layout` las deja más ordenadas que `markitdown`. Para PDFs muy complejos está `docling` (ocupa ~2,8 GB en el store de nix y ~0,5 GB de modelos; ~1,4 GB de RAM y ~8 s por página en CPU, 30 s la primera vez). En una prueba con un PDF sencillo no detectó las tablas: compáralo siempre con `pdftotext -layout`.

`ocrmypdf` y `tesseract` hacen OCR sin IA y son muy rápidos para PDFs completos (incluyen español).
Quitar fondos de imágenes no se instaló a propósito: el móvil, Canva o GIMP lo resuelven mejor.

## De dónde sale cada herramienta

| Origen | Programas |
|---|---|
| Nix, grupo documentos (`packages/nix/documentos.txt`) | `imagemagick`, `docling`, `pandoc`, `qpdf`, `exiftool`, `_7zz` (comando `7zz`), `unar`, `ocrmypdf`, `tesseract`, `ffmpeg`, `poppler-utils`, `ghostscript` |
| Nix, grupo multimedia | `yt-dlp` |
| Nix (`packages/markitdown.nix`) | `markitdown` con soporte de PDF y Office |
| Ya viene con Ubuntu | LibreOffice (`soffice`) |
| Ollama (`packages/ollama.txt`) | los modelos de arriba |
