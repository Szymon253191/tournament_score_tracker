using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using iText.Kernel.Colors;
using iText.Kernel.Font;
using iText.Kernel.Geom;
using iText.Kernel.Pdf;
using iText.Kernel.Pdf.Canvas;
using iText.Kernel.Pdf.Canvas.Draw;
using iText.Layout;
using iText.Layout.Element;
using iText.Layout.Properties;
using TrackerLibrary.Model;

namespace TrackerLibrary
{
    public static class PdfCreator
    {
        public static void Generate(string filename, TournamentModel tournament)
        {
            string pfdName = @"..\..\..\..\PDFs\" + filename + ".pdf";
            string directoryPath = System.IO.Path.GetDirectoryName(pfdName);

            IfDirExists(directoryPath);

            PdfWriter writer = new PdfWriter(pfdName);
            PdfDocument pdfDoc = new PdfDocument(writer);
            pdfDoc.SetDefaultPageSize(PageSize.LETTER.Rotate());
            Document document = new Document(pdfDoc);

            float xMargin = 50f;
            float yMargin = 50f;
            float xSpacing = 50f;
            float ySpacing = 20f;
            float lineWidth = 2f;

            Style titleStyle = new Style()
                .SetFontSize(20f).SetFontColor(ColorConstants.BLACK)
                .SetTextAlignment(TextAlignment.CENTER).SetBold();
            Style teamStyle = new Style()
                .SetFontSize(12f).SetFontColor(ColorConstants.BLACK);
            Paragraph title = new Paragraph("Tournament Bracket").AddStyle(titleStyle);
            document.Add(title);

            document.Add(new Paragraph(" ------------------ "));


            List<MatchupModel> round = tournament.Rounds[0];

            foreach (MatchupModel matchup in round)
            {
                if (matchup.Entries[0].TeamCompeting.TeamName == null)
                {
                    string nameOne = "---";
                    document.Add(new Paragraph(nameOne));
                }
                else
                {
                    string nameOne = matchup.Entries[0].TeamCompeting.TeamName;
                    document.Add(new Paragraph(nameOne));
                }
                if (matchup.Entries.Count == 1)
                {
                    document.Add(new Paragraph(" - BYE - "));
                    document.Add(new Paragraph(" ------------------ "));
                    continue;
                }
                if (matchup.Entries[1].TeamCompeting.TeamName == null)
                {
                    string nameTwo = "---";
                    document.Add(new Paragraph(nameTwo));
                }
                else
                {
                    string nameTwo = matchup.Entries[1].TeamCompeting.TeamName;
                    document.Add(new Paragraph(nameTwo));
                }

                document.Add(new Paragraph(" ------------------ "));
            }

            document.Close();
        }

        private static void IfDirExists(string dir)
        {
            if (!Directory.Exists(dir))
            {
                Directory.CreateDirectory(dir);
            }
        }

        public static void GenerateTEST(string filename, TournamentModel tournament)
        {
            string pfdName = @"..\..\..\..\PDFs\" + filename + ".pdf";
            string directoryPath = System.IO.Path.GetDirectoryName(pfdName);

            IfDirExists(directoryPath);

            PdfWriter writer = new PdfWriter(pfdName);
            PdfDocument pdfDoc = new PdfDocument(writer);
            pdfDoc.SetDefaultPageSize(PageSize.LETTER.Rotate());
            Document document = new Document(pdfDoc);

            float bracketWidth = 300f;
            float bracketHeight = 20f;
            float teamNameFontSize = 12f;
            float lineThickness = 1f;

            Table table = new Table(new float[] { bracketWidth / 2, bracketWidth / 2 });

            foreach (MatchupModel round in tournament.Rounds[0])
            {
                table.AddCell(new Cell().Add(new Paragraph(round.Entries[0].TeamCompeting.TeamName).SetFontSize(teamNameFontSize)));
                if (round.Entries.Count < 2)
                {
                    table.AddCell(new Cell().Add(new Paragraph(" EMPTY ").SetFontSize(teamNameFontSize)));
                }
                else
                {
                    table.AddCell(new Cell().Add(new Paragraph(round.Entries[1].TeamCompeting.TeamName).SetFontSize(teamNameFontSize)));
                }

                table.AddCell(new Cell().Add(new LineSeparator(new SolidLine(lineThickness))));
            }
            document.Add(table);




            document.Close();

            //document.Add(new Paragraph(round.Count.ToString()));
        }

    }
}