<project xmlns="com.autoesl.autopilot.project" name="gost_magma" top="GOST_Encrypt_SR_AXI">
    <includePaths/>
    <libraryPaths/>
    <Simulation>
        <SimFlow name="csim" csimMode="0" lastCsimMode="0"/>
    </Simulation>
    <files xmlns="">
        <file name="../test.cpp" sc="0" tb="1" cflags=" -Wno-unknown-pragmas" csimflags=" -Wno-unknown-pragmas" blackbox="false"/>
        <file name="gost_magma/magma.hpp" sc="0" tb="false" cflags="" csimflags="" blackbox="false"/>
        <file name="gost_magma/magma.cpp" sc="0" tb="false" cflags="" csimflags="" blackbox="false"/>
    </files>
    <solutions xmlns="">
        <solution name="magma" status="active"/>
    </solutions>
</project>

