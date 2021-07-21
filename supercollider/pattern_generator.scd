(
{|synthDef=\default, wrapInPdef=true, randomize=true|
	var controls = SynthDescLib.global.synthDescs.at(synthDef).controls;
	var ret = "";

	if(wrapInPdef, {
		ret = ret ++ "Pdef('%', ".format(rrand(1,10000)) 
	});

	ret = ret ++ "Pbind(";
		ret = ret ++ "%instrument, %%,".format("\\", "\\", synthDef.asSymbol);

		controls.do{|control| 
			var name = control.name;
			var val = control.defaultValue;

			// Check that synth doesn't have a duration of 0 by default (making sc explode)
			val = if(name == \dur && val == 0.0, { 1.0 }, { val });
			val = if(randomize && val.isKindOf(Number), { val * rrand(0.5,1.5) }, { val });
			val = val.trunc(0.001);

			ret = ret ++ "%%, %, ".format("\\", name, val)
		};

		if(wrapInPdef, { ret = ret ++ ")).play" }, {ret = ret ++ ").play" });
	};

)
