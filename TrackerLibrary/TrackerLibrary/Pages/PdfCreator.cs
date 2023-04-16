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
using iText.Layout.Borders;
using iText.Layout.Element;
using iText.Layout.Properties;
using TrackerLibrary.Model;
using iText.Layout.Renderer;
using iText.IO.Util;
using Dapper;

namespace TrackerLibrary
{
    //TODO Make PDFCreator make bracket connection (lines)
    public static class PdfCreator
    {
        private static void IfDirExists(string dir)
        {
            if (!Directory.Exists(dir))
            {
                Directory.CreateDirectory(dir);
            }
        }

        public static void CreateBrackets(string filename, TournamentModel tournament)
        {
            string pfdName = @"..\..\..\..\PDFs\" + filename + ".pdf";
            string directoryPath = System.IO.Path.GetDirectoryName(pfdName);

            IfDirExists(directoryPath);

            PdfWriter writer = new PdfWriter(pfdName);
            PdfDocument pdfDoc = new PdfDocument(writer);
            pdfDoc.SetDefaultPageSize(PageSize.A4.Rotate());
            Document document = new Document(pdfDoc);

            Style titleStyle = new Style()
                .SetFontSize(20f).SetFontColor(ColorConstants.BLACK)
                .SetTextAlignment(TextAlignment.CENTER).SetBold();
            Style teamStyle = new Style()
                .SetFontSize(12f).SetFontColor(ColorConstants.BLACK);
            Paragraph title = new Paragraph($"Tournament: {tournament.TournamentName} - Bracket").AddStyle(titleStyle);
            document.Add(title);

            List<List<MatchupModel>> rounds = tournament.Rounds;

            float rectangleWidth = 100f;
            float rectangleHeight = 20f;
            float rectangleX = 50f;
            float rectangleY = 500f;
            float rectangleYOrgin = rectangleY;

            PdfCanvas canvas = new PdfCanvas(pdfDoc.GetFirstPage());
            canvas.SetStrokeColor(ColorConstants.BLACK)
                .SetLineWidth(1);

            int roundNum = 1;
            foreach (List<MatchupModel> round in rounds)
            {
                foreach (MatchupModel matchup in round)
                {
                    if (matchup.MatchupRound != roundNum)
                    {
                        rectangleY = ((rectangleYOrgin + rectangleY) / 2) + (round.Count * rectangleHeight);
                        //rectangleY = (rectangleYOrgin + rectangleY) / 2 + (rounds.Count - roundNum) * rectangleHeight;
                        roundNum++;
                        rectangleYOrgin = rectangleY;
                    }
                    canvas.Rectangle(rectangleX, rectangleY, rectangleWidth, rectangleHeight)
                        .Stroke();
                    canvas.Rectangle(rectangleX + rectangleWidth, rectangleY, rectangleHeight, rectangleHeight)
                        .Stroke();

                    string text = matchup.DisplayName;

                    string teamOne = "";
                    string teamTwo = "";

                    string scoreOne = "";
                    string scoreTwo = "";

                    if (text.Contains("vs."))
                    {
                        int vsIndex = text.IndexOf("vs.");
                        if (vsIndex >= 0)
                        {
                            teamOne = text.Substring(0, vsIndex).Trim();
                            teamTwo = text.Substring(vsIndex + 3).Trim();
                            scoreOne = matchup.Entries[0].Score.ToString();
                            scoreTwo = matchup.Entries[1].Score.ToString();
                        }
                    }
                    else
                    {
                        teamOne = text;
                        teamTwo = "<BYE>";
                    }
                    if (text == "Matchup not yet determined")
                    {
                        teamOne = "";
                        teamTwo = "";
                    }

                    Paragraph teamName = new Paragraph(teamOne)
                        .SetFontSize(12)
                        .SetFontColor(ColorConstants.BLACK);
                    teamName.SetFixedPosition(rectangleX + 2f, rectangleY + 2f, rectangleWidth - 2f);
                    document.Add(teamName);

                    Paragraph scoreValue = new Paragraph(scoreOne)
                        .SetFontSize(12)
                        .SetFontColor(ColorConstants.BLACK);
                    scoreValue.SetFixedPosition(rectangleX + rectangleWidth + 5f, rectangleY + 2f, rectangleWidth - 2f);
                    document.Add(scoreValue);

                    rectangleY -= 25f;

                    canvas.Rectangle(rectangleX, rectangleY, rectangleWidth, rectangleHeight)
                        .Stroke();
                    canvas.Rectangle(rectangleX + rectangleWidth, rectangleY, rectangleHeight, rectangleHeight)
                        .Stroke();

                    teamName = new Paragraph(teamTwo)
                        .SetFontSize(12)
                        .SetFontColor(ColorConstants.BLACK);
                    teamName.SetFixedPosition(rectangleX + 2f, rectangleY + 2f, rectangleWidth - 2f);
                    document.Add(teamName);

                    scoreValue = new Paragraph(scoreTwo)
                        .SetFontSize(12)
                        .SetFontColor(ColorConstants.BLACK);
                    scoreValue.SetFixedPosition(rectangleX + rectangleWidth + 5f, rectangleY + 2f, rectangleWidth - 2f);
                    document.Add(scoreValue);

                    rectangleY -= 40f;
                }

                rectangleY += 40f;
                rectangleX += 150f;
            }

            // NUMBERS FOR LOOPS

            // ROUND NUMBER: 1,2,3
            // matchup.MatchupRound;

            // NUMBER OF TEAMS IN MATCHUP: 2 if normal, 1 if bye
            // matchup.Entries.Count;

            // NUMBER OF TEAMS IN ROUND: 4 in first, 2 in second, 1 in third
            // round.Count;

            document.Close();
        }
    }
}