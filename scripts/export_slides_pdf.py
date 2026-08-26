from __future__ import annotations

import argparse
import re
import tempfile
from datetime import datetime
from pathlib import Path

from PIL import Image
from playwright.sync_api import sync_playwright


ROOT = Path(__file__).resolve().parent.parent
SLIDES_DIR = ROOT / "site" / "public" / "slides"
OUTPUT_DIR = ROOT / "site" / "public"


def get_slide_files(first: int, last: int) -> list[Path]:
    files = []
    for path in SLIDES_DIR.glob("*.html"):
        match = re.match(r"^(\d+)_", path.name)
        if match and first <= int(match.group(1)) <= last:
            files.append(path)
    return sorted(files, key=lambda path: int(path.stem.split("_", 1)[0]))

def export_pdf(output_path: Path, first: int, last: int) -> None:
    slide_files = get_slide_files(first, last)
    if not slide_files:
        raise SystemExit("Nenhum slide encontrado no intervalo informado.")

    images = []
    with tempfile.TemporaryDirectory(prefix="slides_pdf_") as temp_dir:
        with sync_playwright() as playwright:
            browser = playwright.chromium.launch()
            page = browser.new_page(viewport={"width": 1920, "height": 1080}, device_scale_factor=2)
            page.emulate_media(media="screen")

            for index, slide_file in enumerate(slide_files, start=1):
                page.goto(slide_file.resolve().as_uri(), wait_until="networkidle")
                page.evaluate("document.fonts.ready")
                page.wait_for_timeout(1200)
                image_path = Path(temp_dir) / f"{index:02d}.png"
                page.screenshot(path=str(image_path), full_page=False)
                images.append(Image.open(image_path).convert("RGB"))
                print(f"Slide {slide_file.stem.split('_', 1)[0]} exportado")

            browser.close()

    output_path.parent.mkdir(parents=True, exist_ok=True)
    images[0].save(
        output_path,
        "PDF",
        dpi=(144.0, 144.0),
        save_all=True,
        append_images=images[1:],
    )
    print(f"PDF criado: {output_path}")


def main() -> None:
    parser = argparse.ArgumentParser(description="Exporta os slides HTML para um PDF 16:9.")
    parser.add_argument("--inicio", type=int, default=1, help="Número do primeiro slide")
    parser.add_argument("--fim", type=int, default=20, help="Número do último slide")
    parser.add_argument("--saida", type=Path, help="Caminho do PDF de saída")
    args = parser.parse_args()

    output_path = args.saida or OUTPUT_DIR / f"Apresentacao_Grupo_Lider_{datetime.now():%Y%m%d_%H%M%S}.pdf"
    export_pdf(output_path, args.inicio, args.fim)


if __name__ == "__main__":
    main()