﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using AutoTest.TestRunners.Shared;

namespace AutoTest.TestRunners.Shared.Results
{
    public class ResultsXmlWriter
    {
        private IEnumerable<TestResult> _results;

        public ResultsXmlWriter(IEnumerable<TestResult> results)
        {
            _results = results;
        }

        public string GetXml()
        {
            var sb = new StringBuilder();
            XmlWriterSettings settings = new XmlWriterSettings();
            using (var writer = XmlTextWriter.Create(sb, settings))
            {
                generateXml(writer);
            }
            return sb.ToString();
        }

        public void Write(string file)
        {
            XmlWriterSettings settings = new XmlWriterSettings();
            settings.Indent = true;
            settings.NewLineChars = Environment.NewLine;
            using (var writer = XmlTextWriter.Create(file, settings))
            {
                generateXml(writer);
            }
        }

        private void generateXml(XmlWriter writer)
        {
            writer.WriteStartDocument();
            writer.WriteStartElement("results");
            foreach (var runner in _results.GroupBy(x => x.Runner))
            {
                writer.WriteStartElement("runner");
                writer.WriteAttributeString("id", runner.Key);
                foreach (var assembly in runner.GroupBy(x => x.Assembly))
                {
                    writer.WriteStartElement("assembly");
                    writer.WriteAttributeString("name", assembly.Key);
                    foreach (var fixture in assembly.GroupBy(x => x.TestFixture))
                    {
                        writer.WriteStartElement("fixture");
                        writer.WriteAttributeString("name", fixture.Key);
                        foreach (var test in fixture)
                        {
                            writer.WriteStartElement("test");
                            writer.WriteAttributeString("state", test.State.ToString());
                            writer.WriteAttributeString("name", test.TestName);
                            if (test.TestDisplayName != null)
                                writer.WriteAttributeString("displayName", test.TestDisplayName);
                            writer.WriteAttributeString("duration", test.DurationInMilliseconds.ToString());
                            writer.WriteStartElement("message");
                            writer.WriteCData(test.Message);
                            writer.WriteEndElement();
                            if (test.State == TestState.Failed || test.State == TestState.Ignored)
                            {
                                writer.WriteStartElement("stack-trace");
                                foreach (var line in test.StackLines)
                                {
                                    writer.WriteStartElement("line");
                                    writer.WriteStartElement("method");
                                    writer.WriteCData(line.Method);
                                    writer.WriteEndElement();
                                    writer.WriteStartElement("file");
                                    writer.WriteAttributeString("line", line.Line.ToString());
                                    writer.WriteRaw(line.File);
                                    writer.WriteEndElement();
                                    writer.WriteEndElement();
                                }
                                writer.WriteEndElement();
                            }
                            writer.WriteEndElement();
                        }
                        writer.WriteEndElement();
                    }
                    writer.WriteEndElement();
                }
                writer.WriteEndElement();
            }
            writer.WriteEndElement();
        }
    }
}
