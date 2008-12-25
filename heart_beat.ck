OscRecv recv;
6450 => recv.port;
recv.listen();

float cpu;

fun void get_cpu() {
    recv.event("/tot, f") @=> OscEvent oe;
    while (true) {
        oe => now;
        while (oe.nextMsg() !=0) {
            oe.getFloat() => cpu;
        }
    }
}

spork ~get_cpu();
me.yield;


SndBuf buf1 => dac;
"/home/mos/scripts/chuck/talk/heart_beat.wav" => buf1.read;
1 => buf1.loop;
2 => buf1.gain;
while (true) {
    1+3 * cpu/300 => buf1.freq;
    <<<cpu, buf1.freq()>>>;
    2::second => now;
}
