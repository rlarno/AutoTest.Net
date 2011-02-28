#!/bin/bash
# stty -echo

BINARYDIR="./build_outputAnyCPU/AutoTest.NET"
BINARYDIRx86="./build_outputx86/AutoTest.TestRunner"
DEPLOYDIR="./ReleaseBinaries"
CASTLEDIR="./lib/Castle.Windsor"
VSADDINDIR="./addins/VisualStudio/FilesToDeploy"
RESOURCES="./src/Resources"

if [ ! -d $DEPLOYDIR ]; then
{
	mkdir $DEPLOYDIR
	mkdir $DEPLOYDIR/Icons
	mkdir $DEPLOYDIR/TestRunners
}
else
{
	rm -rf $DEPLOYDIR/*
	mkdir $DEPLOYDIR/Icons
	mkdir $DEPLOYDIR/TestRunners
}
fi


cp $BINARYDIR/AutoTest.Messages.dll $DEPLOYDIR/AutoTest.Messages.dll
cp $BINARYDIR/AutoTest.Core.dll $DEPLOYDIR/AutoTest.Core.dll
cp $BINARYDIR/AutoTest.Console.exe $DEPLOYDIR/AutoTest.Console.exe
cp $BINARYDIR/AutoTest.WinForms.exe $DEPLOYDIR/AutoTest.WinForms.exe
cp $BINARYDIR/AutoTest.config.template $DEPLOYDIR/AutoTest.config
cp ./README $DEPLOYDIR/README
cp ./LICENSE $DEPLOYDIR/AutoTest.License.txt

cp $BINARYDIR/AutoTest.TestRunner.exe $DEPLOYDIR/AutoTest.TestRunner.exe
cp $BINARYDIR/AutoTest.TestRunner.exe $DEPLOYDIR/AutoTest.TestRunner.v4.0.exe
cp $BINARYDIR/AutoTest.TestRunner.exe.config $DEPLOYDIR/AutoTest.TestRunner.v4.0.exe.config
cp $BINARYDIRx86/AutoTest.TestRunner.exe $DEPLOYDIR/AutoTest.TestRunner.x86.exe
cp $BINARYDIRx86/AutoTest.TestRunner.exe $DEPLOYDIR/AutoTest.TestRunner.x86.v4.0.exe
cp $BINARYDIRx86/AutoTest.TestRunner.exe.config $DEPLOYDIR/AutoTest.TestRunner.x86.v4.0.exe.config
cp $BINARYDIR/AutoTest.TestRunners.Shared.dll $DEPLOYDIR/AutoTest.TestRunners.Shared.dll
cp $BINARYDIR/AutoTest.TestRunners.NUnit.dll $DEPLOYDIR/TestRunners/AutoTest.TestRunners.NUnit.dll
cp $BINARYDIR/AutoTest.TestRunners.XUnit.dll $DEPLOYDIR/TestRunners/AutoTest.TestRunners.XUnit.dll
cp $BINARYDIR/AutoTest.TestRunners.MSTest.dll $DEPLOYDIR/TestRunners/AutoTest.TestRunners.MSTest.dll
cp $BINARYDIR/nunit.core.dll $DEPLOYDIR/TestRunners/nunit.core.dll
cp $BINARYDIR/nunit.core.interfaces.dll $DEPLOYDIR/TestRunners/nunit.core.interfaces.dll
cp $BINARYDIR/nunit.util.dll $DEPLOYDIR/TestRunners/nunit.util.dll
cp $BINARYDIR/xunit.runner.utility.dll $DEPLOYDIR/TestRunners/xunit.runner.utility.dll
cp $BINARYDIR/celer.Core.dll $DEPLOYDIR/TestRunners/celer.Core.dll

cp $BINARYDIR/Castle.Core.dll $DEPLOYDIR/Castle.Core.dll
cp $BINARYDIR/Castle.Facilities.Logging.dll $DEPLOYDIR/Castle.Facilities.Logging.dll
cp $CASTLEDIR/Castle.license.txt $DEPLOYDIR/Castle.license.txt
cp $BINARYDIR/Castle.Windsor.dll $DEPLOYDIR/Castle.Windsor.dll
cp $BINARYDIR/Mono.Cecil.dll $DEPLOYDIR/Mono.Cecil.dll

cp ./$RESOURCES/* $DEPLOYDIR/Icons
