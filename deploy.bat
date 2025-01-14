@echo off

SET DIR=%~d0%~p0%
SET BINARYDIR="%DIR%build_outputAnyCPU\AutoTest.NET"
SET BINARYDIRx86="%DIR%build_outputx86\AutoTest.TestRunner"
SET DEPLOYDIR="%DIR%ReleaseBinaries"
SET CASTLEDIR="%DIR%lib\Castle.Windsor"
SET MSPEC3DIR="%DIR%lib\MSpec3"
SET MSPEC4DIR="%DIR%lib\MSpec"
SET VSADDINDIR="%DIR%addins\VisualStudio\FilesToDeploy"
SET RESOURCES="%DIR%src\Resources"

IF NOT EXIST %DEPLOYDIR% (
  mkdir %DEPLOYDIR%
  mkdir %DEPLOYDIR%\Icons
  mkdir %DEPLOYDIR%\TestRunners
  mkdir %DEPLOYDIR%\TestRunners\NUnit
  mkdir %DEPLOYDIR%\TestRunners\XUnit
  mkdir %DEPLOYDIR%\TestRunners\MSTest
  mkdir %DEPLOYDIR%\TestRunners\MSpec
  mkdir %DEPLOYDIR%\TestRunners\MSpec4
  mkdir %DEPLOYDIR%\TestRunners\MbUnit
) ELSE (
  IF NOT EXIST %DEPLOYDIR%\Icons (
	mkdir %DEPLOYDIR%\Icons
  ) ELSE (
	del %DEPLOYDIR%\Icons\* /Q
  )
  IF NOT EXIST %DEPLOYDIR%\TestRunners (
	mkdir %DEPLOYDIR%\TestRunners
	mkdir %DEPLOYDIR%\TestRunners\NUnit
	mkdir %DEPLOYDIR%\TestRunners\XUnit
	mkdir %DEPLOYDIR%\TestRunners\MSTest
	mkdir %DEPLOYDIR%\TestRunners\MSpec
	mkdir %DEPLOYDIR%\TestRunners\MSpec4
	mkdir %DEPLOYDIR%\TestRunners\MbUnit
  ) ELSE (
	IF NOT EXIST %DEPLOYDIR%\TestRunners\NUnit (
		mkdir %DEPLOYDIR%\TestRunners\NUnit
	) ELSE (
		del %DEPLOYDIR%\TestRunners\NUnit\* /Q
	)
	IF NOT EXIST %DEPLOYDIR%\TestRunners\XUnit (
		mkdir %DEPLOYDIR%\TestRunners\XUnit
	) ELSE (
		del %DEPLOYDIR%\TestRunners\XUnit\* /Q
	)
	IF NOT EXIST %DEPLOYDIR%\TestRunners\MSTest (
		mkdir %DEPLOYDIR%\TestRunners\MSTest
	) ELSE (
		del %DEPLOYDIR%\TestRunners\MSTest\* /Q
	)
	IF NOT EXIST %DEPLOYDIR%\TestRunners\MSpec (
		mkdir %DEPLOYDIR%\TestRunners\MSpec
	) ELSE (
		del %DEPLOYDIR%\TestRunners\MSpec\* /Q
	)
	IF NOT EXIST %DEPLOYDIR%\TestRunners\MSpec4 (
		mkdir %DEPLOYDIR%\TestRunners\MSpec4
	) ELSE (
		del %DEPLOYDIR%\TestRunners\MSpec4\* /Q
	)
	IF NOT EXIST %DEPLOYDIR%\TestRunners\MbUnit (
		mkdir %DEPLOYDIR%\TestRunners\MbUnit
	) ELSE (
		del %DEPLOYDIR%\TestRunners\MbUnit\* /Q
	)
	del %DEPLOYDIR%\TestRunners\* /Q
  )
  del  %DEPLOYDIR%\* /Q
)

copy %BINARYDIR%\AutoTest.Messages.dll %DEPLOYDIR%\AutoTest.Messages.dll
copy %BINARYDIR%\AutoTest.Core.dll %DEPLOYDIR%\AutoTest.Core.dll
copy %BINARYDIR%\AutoTest.Console.exe %DEPLOYDIR%\AutoTest.Console.exe
copy %BINARYDIR%\AutoTest.UI.dll %DEPLOYDIR%\AutoTest.UI.dll
copy %BINARYDIR%\AutoTest.WinForms.exe %DEPLOYDIR%\AutoTest.WinForms.exe
copy %BINARYDIR%\AutoTest.config.template %DEPLOYDIR%\AutoTest.config
copy %DIR%README %DEPLOYDIR%\README
copy %DIR%LICENSE %DEPLOYDIR%\AutoTest.License.txt

copy %BINARYDIR%\AutoTest.TestRunner.exe %DEPLOYDIR%\AutoTest.TestRunner.exe
copy %BINARYDIR%\AutoTest.TestRunner.exe %DEPLOYDIR%\AutoTest.TestRunner.v4.0.exe
copy %BINARYDIR%\AutoTest.TestRunner.exe.config %DEPLOYDIR%\AutoTest.TestRunner.v4.0.exe.config
copy %BINARYDIRx86%\AutoTest.TestRunner.exe %DEPLOYDIR%\AutoTest.TestRunner.x86.exe
copy %BINARYDIRx86%\AutoTest.TestRunner.exe %DEPLOYDIR%\AutoTest.TestRunner.x86.v4.0.exe
copy %BINARYDIRx86%\AutoTest.TestRunner.exe.config %DEPLOYDIR%\AutoTest.TestRunner.x86.v4.0.exe.config
copy %BINARYDIR%\AutoTest.TestRunners.Shared.dll %DEPLOYDIR%\AutoTest.TestRunners.Shared.dll

copy %BINARYDIR%\AutoTest.TestRunners.NUnit.dll %DEPLOYDIR%\TestRunners\NUnit\AutoTest.TestRunners.NUnit.dll
copy %BINARYDIR%\nunit.core.dll %DEPLOYDIR%\TestRunners\NUnit\nunit.core.dll
copy %BINARYDIR%\nunit.core.interfaces.dll %DEPLOYDIR%\TestRunners\NUnit\nunit.core.interfaces.dll
copy %BINARYDIR%\nunit.util.dll %DEPLOYDIR%\TestRunners\NUnit\nunit.util.dll

copy %BINARYDIR%\AutoTest.TestRunners.XUnit.dll %DEPLOYDIR%\TestRunners\XUnit\AutoTest.TestRunners.XUnit.dll
copy %BINARYDIR%\xunit.runner.utility.dll %DEPLOYDIR%\TestRunners\XUnit\xunit.runner.utility.dll

copy %BINARYDIR%\AutoTest.TestRunners.MSTest.dll %DEPLOYDIR%\TestRunners\MSTest\AutoTest.TestRunners.MSTest.dll
copy %BINARYDIR%\celer.Core.dll %DEPLOYDIR%\TestRunners\MSTest\celer.Core.dll

copy %BINARYDIR%\AutoTest.TestRunners.MSpec.dll %DEPLOYDIR%\TestRunners\MSpec\AutoTest.TestRunners.MSpec.dll
copy %MSPEC3DIR%\Machine.Specifications.dll %DEPLOYDIR%\TestRunners\MSpec\Machine.Specifications.dll

copy %BINARYDIR%\AutoTest.TestRunners.MSpec4.dll %DEPLOYDIR%\TestRunners\MSpec4\AutoTest.TestRunners.MSpec4.dll
copy %MSPEC4DIR%\Machine.Specifications.dll %DEPLOYDIR%\TestRunners\MSpec4\Machine.Specifications.dll

copy %BINARYDIR%\AutoTest.TestRunners.MbUnit.dll %DEPLOYDIR%\TestRunners\MbUnit\AutoTest.TestRunners.MbUnit.dll
copy %BINARYDIR%\Gallio.dll %DEPLOYDIR%\TestRunners\MbUnit\Gallio.dll
copy %DIR%\lib\Gallio\Gallio.XmlSerializers.dll %DEPLOYDIR%\TestRunners\MbUnit\Gallio.XmlSerializers.dll
copy %BINARYDIR%\mbunit.config %DEPLOYDIR%\TestRunners\MbUnit\mbunit.config

copy %BINARYDIR%\Castle.Core.dll %DEPLOYDIR%\Castle.Core.dll
copy %BINARYDIR%\Castle.Facilities.Logging.dll %DEPLOYDIR%\Castle.Facilities.Logging.dll
copy %CASTLEDIR%\Castle.license.txt %DEPLOYDIR%\Castle.license.txt
copy %BINARYDIR%\Castle.Windsor.dll %DEPLOYDIR%\Castle.Windsor.dll
copy %BINARYDIR%\Mono.Cecil.dll %DEPLOYDIR%\Mono.Cecil.dll

copy %RESOURCES%\* %DEPLOYDIR%\Icons
