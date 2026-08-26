#!/usr/bin/env python3
"""
Exporta slides HTML para PowerPoint (.pptx)
Lê arquivos HTML da pasta public/slides e cria uma apresentação
"""

import os
import re
from pathlib import Path
from pptx import Presentation
from pptx.util import Inches, Pt
from pptx.enum.text import PP_ALIGN
from pptx.dml.color import RGBColor
from bs4 import BeautifulSoup
from datetime import datetime

def get_slide_files():
    """Retorna lista de arquivos de slide em ordem"""
    slides_dir = Path(__file__).parent.parent / "site" / "public" / "slides"
    files = sorted(slides_dir.glob("*.html"), key=lambda x: int(x.stem.split("_")[0]))
    return files

def extract_text_from_html(html_content):
    """Extrai texto do HTML de forma legível"""
    soup = BeautifulSoup(html_content, 'html.parser')
    
    # Remove scripts e styles
    for tag in soup(['script', 'style']):
        tag.decompose()
    
    # Get text
    text = soup.get_text(separator=' ', strip=True)
    
    # Clean up multiple spaces
    text = re.sub(r'\s+', ' ', text).strip()
    
    return text[:500]  # Limit to 500 chars per slide

def export_to_pptx(output_path=None):
    """
    Exporta todos os slides HTML para PowerPoint
    """
    if output_path is None:
        output_dir = Path(__file__).parent.parent / "site" / "public"
        output_dir.mkdir(exist_ok=True)
        output_path = output_dir / f"Apresentacao_Grupo_Lider_{datetime.now().strftime('%Y%m%d_%H%M%S')}.pptx"
    
    # Create presentation
    prs = Presentation()
    prs.slide_width = Inches(10)
    prs.slide_height = Inches(7.5)
    
    slide_files = get_slide_files()
    
    for slide_file in slide_files:
        try:
            with open(slide_file, 'r', encoding='utf-8') as f:
                html_content = f.read()
            
            # Extract info from HTML
            soup = BeautifulSoup(html_content, 'html.parser')
            title_tag = soup.find('title')
            title = title_tag.text if title_tag else slide_file.stem
            
            # Extract main text/heading
            h1 = soup.find('h1')
            heading = h1.text if h1 else title
            
            # Create slide
            slide = prs.slides.add_slide(prs.slide_layouts[6])  # Blank layout
            
            # Add background color
            background = slide.background
            fill = background.fill
            fill.solid()
            fill.fore_color.rgb = RGBColor(7, 24, 39)  # #071827
            
            # Add title
            title_box = slide.shapes.add_textbox(Inches(0.5), Inches(0.5), Inches(9), Inches(1))
            title_frame = title_box.text_frame
            title_frame.word_wrap = True
            p = title_frame.paragraphs[0]
            p.text = heading[:100]
            p.font.size = Pt(44)
            p.font.bold = True
            p.font.color.rgb = RGBColor(255, 255, 255)
            
            # Add slide number and source
            info_box = slide.shapes.add_textbox(Inches(0.5), Inches(6.8), Inches(9), Inches(0.5))
            info_frame = info_box.text_frame
            info_frame.word_wrap = True
            p = info_frame.paragraphs[0]
            p.text = f"Grupo Líder Supermercados | Controladoria | {slide_file.stem}"
            p.font.size = Pt(10)
            p.font.color.rgb = RGBColor(100, 116, 139)
            
            print(f"✓ Slide criado: {slide_file.name}")
            
        except Exception as e:
            print(f"✗ Erro ao processar {slide_file.name}: {e}")
            continue
    
    # Save presentation
    prs.save(str(output_path))
    print(f"\n✅ Apresentação exportada com sucesso: {output_path}")
    return str(output_path)

if __name__ == "__main__":
    export_to_pptx()
