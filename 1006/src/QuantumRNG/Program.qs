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

    operation SampleRandomNumberInRange(min: Int, max : Int) : Int {
        mutable output = 0;
        repeat {
            mutable bits = [];
            for idxBit in 1..BitSizeI(max) {
                set bits += [GenerateRandomBit()];
            }
            set output = ResultArrayAsInt(bits);
        } until (output >= min and output <= max);
        return output;
    }

    operation SampleRandomCharacter() : Int {
        mutable output = 0;
        let numBits = 7;
        repeat {
            mutable bits = [];
            for idxBit in 1..7 {
                set bits += [GenerateRandomBit()];
            }
            set output = ResultArrayAsInt(bits);
        } until (output > 20 and output < 127)

        return output;

        // mutable character = Microsoft.Quantum.Convert.IntAsString(output);
        // return character;
    }

    operation GenerateRandomPassword(length : Int) : Int {
        mutable password = 0;
        for _ in 1..length {
            set password += SampleRandomCharacter();
        }
        return password;
    }

    @EntryPoint()
    operation SampleRandomNumber() : Int {
        let max = 10000;
        let min = 1000;
        let length = 2;
        // Message($"Sampling a random number between {min} and {max}: ");
        // return SampleRandomNumberInRange(min, max);
        Message($"Sampling a random character: ");
        return GenerateRandomPassword(length);
        // Bug: No function to change int to string or char in Qsharp.
    }
}
