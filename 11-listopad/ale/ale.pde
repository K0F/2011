import java.awt.image.Kernel.*;

KernelJAI kernel;

float[] kernelData = {
	0.0F,        1.0F,        0.0F,
	1.0F,        1.0F,        1.0F,
	0.0F,        1.0F,        0.0F
};


void setup(){


	kernel = new KernelJAI(3, 3, 1, 1, kernelData);
}
