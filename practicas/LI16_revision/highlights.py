from docx import Document
from docx.enum.text import WD_COLOR_INDEX
p=r'F:\BIG_DATA\LI16_Informe_EduardoAntezana.docx'; d=Document(p)
for i,para in enumerate(d.paragraphs):
    text=para.text.strip()
    if text:
        highlighted=[]
        for r in para.runs:
            if r.font.highlight_color:
                highlighted.append((r.text,str(r.font.highlight_color)))
        if highlighted or text.startswith(('Listar','Acceder','Abrir','Crear','Verificar','Cargar','1. Determinar','2. Determinar','3. Determinar','4. Determinar','5. Encontrar','6. ¿','7. ¿')):
            print(i,repr(text),'HIGHLIGHT',highlighted)
