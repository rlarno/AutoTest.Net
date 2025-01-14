﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NUnit.Framework;
using AutoTest.Messages.FileStorage;
using System.IO;

namespace AutoTest.Test.Messages.FileStorage
{
    [TestFixture]
    public class PathTranslatorTests
    {
        private List<string> _createdDirectories = new List<string>();

        private Func<string, bool> _directoryExists = (s) => { return false; };
        private Action<string> _createDirectory = null;

        [SetUp]
        public void Setup()
        {
            _createdDirectories = new List<string>();
            _createDirectory =  (s) => _createdDirectories.Add(s);
        }

        [Test]
        public void When_having_a_solution_file_watch_token_it_will_translate_to_the_same_path_as_directory()
        {
            var directory = new PathTranslator(format("/StorageLocation"), format("/home/ack/src/MySolution"), _directoryExists, _createDirectory)
                .Translate(format("/home/ack/src/MySolution/Project/Project.csproj"));
            var file = new PathTranslator(format("/StorageLocation"), format("/home/ack/src/MySolution"), _directoryExists, _createDirectory)
                .Translate(format("/home/ack/src/MySolution/Project/Project.csproj"));
            Assert.That(
                directory,
                Is.EqualTo(format("/StorageLocation/MySolution_cdd8fcbb3e82fce3dc5b40e585a4949d/Project_f1d7213851ba028add97b0669af210b6/Project.csproj")));
            Assert.That(
                file,
                Is.EqualTo(format("/StorageLocation/MySolution_cdd8fcbb3e82fce3dc5b40e585a4949d/Project_f1d7213851ba028add97b0669af210b6/Project.csproj")));
            Assert.That(file, Is.EqualTo(directory));
        }

        [Test]
        public void When_given_a_token_ending_with_directory_separator_it_will_parse_as_usual()
        {
            var directory = new PathTranslator(format("/StorageLocation"), format("/home/ack/src/MySolution/"), _directoryExists, _createDirectory)
                .Translate(format("/home/ack/src/MySolution/Project/Project.csproj"));
            Assert.That(
                directory,
                Is.EqualTo(format("/StorageLocation/MySolution_cdd8fcbb3e82fce3dc5b40e585a4949d/Project_f1d7213851ba028add97b0669af210b6/Project.csproj")));
        }

        [Test]
        public void When_given_a_file_on_solution_root_it_should_place_it_on_storage_solution_root()
        {
            var directory = new PathTranslator(format("/StorageLocation"), format("/home/ack/src/MySolution/SomeSolution.sln"), _directoryExists, _createDirectory)
                .Translate(format("/home/ack/src/MySolution/SomeFileOnRoot.txt"));
            Assert.That(
                directory,
                Is.EqualTo(format("/StorageLocation/MySolution_cdd8fcbb3e82fce3dc5b40e585a4949d/SomeFileOnRoot.txt")));
        }

        [Test]
        public void When_given_configuration_file_it_should_place_it_the_configuration_space()
        {
            var directory = new PathTranslator(format("/StorageLocation"), format("/home/ack/src/MySolution/SomeSolution.sln"), _directoryExists, _createDirectory)
                .Translate(format("/home/ack/src/MySolution/AutoTest.config"));
            Assert.That(
                directory,
                Is.EqualTo(format("/StorageLocation/Configuration/MySolution_cdd8fcbb3e82fce3dc5b40e585a4949d/AutoTest.config")));
        }

        [Test]
        public void When_given_mm_dll_file_it_should_place_it_the_cache_space()
        {
            var directory = new PathTranslator(format("/StorageLocation"), format("/home/ack/src/MySolution/SomeSolution.sln"), _directoryExists, _createDirectory)
                .Translate(format("/home/ack/src/MySolution/Project/bin/autotest.net/project.mm.dll"));
            Assert.That(
                directory,
                Is.EqualTo(format("/home/ack/src/MySolution/Project/bin/autotest.net/project.mm.dll")));
        }

        [Test]
        public void When_given_mm_exe_file_it_should_place_it_the_cache_space()
        {
            var directory = new PathTranslator(format("/StorageLocation"), format("/home/ack/src/MySolution/SomeSolution.sln"), _directoryExists, _createDirectory)
                .Translate(format("/home/ack/src/MySolution/Project/bin/autotest.net/project.mm.exe"));
            Assert.That(
                directory,
                Is.EqualTo(format("/home/ack/src/MySolution/Project/bin/autotest.net/project.mm.exe")));
        }

        [Test]
        public void When_given_mm_cache_bin_file_it_should_place_it_the_cache_space()
        {
            var directory = new PathTranslator(format("/StorageLocation"), format("/home/ack/src/MySolution/SomeSolution.sln"), _directoryExists, _createDirectory)
                .Translate(format("/home/ack/src/MySolution/Project/bin/autotest.net/projectmm_cache.bin"));
            Assert.That(
                directory,
                Is.EqualTo(format("/StorageLocation/Cache/MySolution_cdd8fcbb3e82fce3dc5b40e585a4949d/projectmm_cache_c39a9a2c31917ec0f174c8bde0fdb00a/projectmm_cache.bin")));
        }

        [Test]
        public void When_given_a_storage_location_ending_with_directory_separator_it_will_parse_as_usual()
        {
            var directory = new PathTranslator(format("/StorageLocation/"), format("/home/ack/src/MySolution"), _directoryExists, _createDirectory)
                .Translate(format("/home/ack/src/MySolution/Project/Project.csproj"));
            Assert.That(
                directory,
                Is.EqualTo(format("/StorageLocation/MySolution_cdd8fcbb3e82fce3dc5b40e585a4949d/Project_f1d7213851ba028add97b0669af210b6/Project.csproj")));
        }

        [Test]
        public void When_returning_a_storage_apth_it_will_make_sure_that_all_directories_exists()
        {
            var directory = new PathTranslator(format("/StorageLocation/"), format("/home/ack/src/MySolution"), _directoryExists, _createDirectory)
                .Translate(format("/home/ack/src/MySolution/Project/Project.csproj"));

            Assert.That(_createdDirectories, Contains.Item(format("/StorageLocation")));
            Assert.That(_createdDirectories, Contains.Item(format("/StorageLocation/MySolution_cdd8fcbb3e82fce3dc5b40e585a4949d")));
            Assert.That(_createdDirectories, Contains.Item(format("/StorageLocation/MySolution_cdd8fcbb3e82fce3dc5b40e585a4949d/Project_f1d7213851ba028add97b0669af210b6")));
        }

        [Test]
        public void When_given_a_project_outside_the_solution_tree_it_will_use_an_alternative_storage_under_the_solution_location()
        {
            var directory = new PathTranslator(format("/StorageLocation/"), format("/home/ack/src/MySolution/ASolution.sln"), _directoryExists, _createDirectory)
                .Translate(format("/home/some/other/location/Project/Project.csproj"));
            Assert.That(
                directory,
                Is.EqualTo(format("/StorageLocation/MySolution_cdd8fcbb3e82fce3dc5b40e585a4949d/Project_c1657f5a6230c5e986018dd389088a6e/Project.csproj")));
        }

        [Test]
        public void When_given_null_as_watch_token_it_will_respond_with_null()
        {
            var directory = new PathTranslator(format("/StorageLocation/"), null, _directoryExists, _createDirectory)
                .Translate(format("/home/some/other/location/Project/Project.csproj"));
            Assert.That(
                directory,
                Is.Null);
        }

        [Test]
        public void When_given_null_as_path_to_translate_it_will_respond_with_null()
        {
            var directory = new PathTranslator(format("/StorageLocation/"), format("/home/ack/src/MySolution"), _directoryExists, _createDirectory)
                .Translate(null);
            Assert.That(
                directory,
                Is.Null);
        }

        [Test]
        public void When_translating_from_a_storage_url_that_has_been_translated_to_it_will_return_original_url()
        {
            var toTranslate = format("/home/ack/src/MySolution/Project/Project.csproj");
            var translator = new PathTranslator(format("/StorageLocation/"), format("/home/ack/src/MySolution"), _directoryExists, _createDirectory);
            var directory = translator.Translate(toTranslate);
            Assert.That(translator.TranslateFrom(directory), Is.EqualTo(toTranslate));
        }

        [Test]
        public void When_translating_from_a_storage_url_that_has_not_been_translated_to_it_will_return_null()
        {
            var translator = new PathTranslator(format("/StorageLocation/"), format("/home/ack/src/MySolution"), _directoryExists, _createDirectory);
            Assert.That(translator.TranslateFrom(format("/home/ack/src/MySolution/Project/ProjectNonExistent.csproj")), Is.Null);
        }

        private string format(string path)
        {
            return path.Replace('/', Path.DirectorySeparatorChar);
        }
    }
}
