class Gen {
  
  boolean source_hidden_layer;
  int id_source_neuron;
  int id_target_neuron;
  float weight;
  
  Gen(){
    source_hidden_layer = (random(1) < 0.5);
    id_source_neuron = (int)random(0, 7);
    if (source_hidden_layer){
      id_target_neuron = (int)random(0, 7);
    } else {
      id_target_neuron = (int)random(0, 2);
    }
    weight = random(-1, 1);
  }
  
}

class Genome {
  
  int length;
  ArrayList<Gen> genes;
  float[] hidden_layer_bias;
  float[] output_layer_bias;

  Genome(){
    length = 16;
    genes = new ArrayList<Gen>();
    for (int i = 0; i < length; i++){
      genes.add(new Gen());
    }
    hidden_layer_bias = random_vector(7);
    output_layer_bias = random_vector(2);
  }

  Genome copy(){
    Genome copy = new Genome();
    for (int i = 0; i < length; i++){
      copy.genes.set(i, genes.get(i));
    }
    for (int i = 0; i < 7; i++){
      copy.hidden_layer_bias[i] = hidden_layer_bias[i];
    }
