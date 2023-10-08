namespace QuantumRNG {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    
    operation GenerateRandomBit() : Result {
        // Allocate a qubit.
        use q = Qubit();
        mutable result = Zero;
        // Put the qubit to superposition using a Hadamard gate.
        H(q);
        // It is now at a true 50% chance of being 0 or 1.
        // Measure the qubit and return the result.
        set result = M(q);
        // Release the qubit.
        Reset(q);
        return result;
    }

    operation SampleRandomNumberInRange(max : Int) : Int {
        mutable output = 0;
        repeat {
            mutable bits = [];
            for idxBit in 1..BitSizeI(max) {
                set bits += [GenerateRandomBit()];
            }
            set output = ResultArrayAsInt(bits);
        } until (output <= max);
        return output;
    }

    @EntryPoint()
    operation SampleRandomNumber() : Int {
        let max = 10000;
        Message($"Sampling a random number between 0 and {max}: ");
        return SampleRandomNumberInRange(max);
    }
}
