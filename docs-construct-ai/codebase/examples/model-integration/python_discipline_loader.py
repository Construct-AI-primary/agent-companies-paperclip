#!/usr/bin/env python3
"""
Python Discipline Model Loader
Complete implementation for loading and using LoRA-adapted Qwen models
"""

import os
import torch
from transformers import AutoTokenizer, AutoModelForCausalLM
from peft import PeftModel
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class DisciplineModelLoader:
    """Complete LoRA adapter integration for Qwen models"""

    def __init__(self, base_model="Qwen/Qwen2.5-7B-Instruct", device=None):
        self.base_model = base_model
        self.device = device or ("cuda" if torch.cuda.is_available() else "cpu")
        self.loaded_models = {}
        self.tokenizers = {}

        logger.info(f"Initialized DisciplineModelLoader with device: {self.device}")

    def load_discipline_model(self, discipline: str, model_path: str = None):
        """
        Load base model + LoRA adapter for specific discipline

        Args:
            discipline: Name of the discipline (e.g., 'building_operations')
            model_path: Optional custom path to model directory
        """
        try:
            model_key = f"{discipline}_model"
            tokenizer_key = f"{discipline}_tokenizer"

            # Check if already loaded
            if model_key in self.loaded_models:
                logger.info(f"Model {discipline} already loaded")
                return self.loaded_models[model_key], self.tokenizers[tokenizer_key]

            # Determine model path
            if model_path is None:
                model_path = f"./models/trained-models/{discipline}"

            if not os.path.exists(model_path):
                raise FileNotFoundError(f"Model path not found: {model_path}")

            logger.info(f"Loading {discipline} model from {model_path}")

            # Load base model with memory optimization
            model = AutoModelForCausalLM.from_pretrained(
                self.base_model,
                torch_dtype=torch.float16,
                device_map="auto" if self.device == "cuda" else None,
                trust_remote_code=True,
                load_in_8bit=True  # Memory optimization
            )

            # Load tokenizer
            tokenizer = AutoTokenizer.from_pretrained(
                self.base_model,
                trust_remote_code=True
            )

            # Apply LoRA adapter
            model = PeftModel.from_pretrained(
                model,
                model_path,
                torch_dtype=torch.float16
            )

            # Store loaded models
            self.loaded_models[model_key] = model
            self.tokenizers[tokenizer_key] = tokenizer

            logger.info(f"✅ Successfully loaded {discipline} model")
            return model, tokenizer

        except Exception as e:
            logger.error(f"❌ Failed to load {discipline} model: {e}")
            raise

    def generate_response(self, discipline: str, prompt: str, **kwargs):
        """
        Generate response using loaded discipline model

        Args:
            discipline: Discipline name
            prompt: Input prompt
            **kwargs: Generation parameters
        """
        try:
            model_key = f"{discipline}_model"
            tokenizer_key = f"{discipline}_tokenizer"

            if model_key not in self.loaded_models:
                raise ValueError(f"Model {discipline} not loaded. Call load_discipline_model() first.")

            model = self.loaded_models[model_key]
            tokenizer = self.tokenizers[tokenizer_key]

            # Default generation parameters
            generation_kwargs = {
                "max_new_tokens": kwargs.get("max_new_tokens", 512),
                "temperature": kwargs.get("temperature", 0.7),
                "do_sample": kwargs.get("do_sample", True),
                "pad_token_id": tokenizer.eos_token_id,
                "use_cache": True
            }
            generation_kwargs.update(kwargs)

            # Format prompt with discipline context
            formatted_prompt = f"You are a {discipline.replace('_', ' ')} expert. {prompt}"

            # Tokenize
            inputs = tokenizer(formatted_prompt, return_tensors="pt").to(self.device)

            # Generate
            with torch.no_grad():
                outputs = model.generate(**inputs, **generation_kwargs)

            # Decode response
            response = tokenizer.decode(outputs[0], skip_special_tokens=True)

            # Remove the input prompt from response
            if response.startswith(formatted_prompt):
                response = response[len(formatted_prompt):].strip()

            return response

        except Exception as e:
            logger.error(f"❌ Generation failed for {discipline}: {e}")
            raise

    def unload_model(self, discipline: str):
        """Unload model to free memory"""
        model_key = f"{discipline}_model"
        tokenizer_key = f"{discipline}_tokenizer"

        if model_key in self.loaded_models:
            del self.loaded_models[model_key]
            del self.tokenizers[tokenizer_key]
            logger.info(f"Unloaded {discipline} model")

    def list_available_disciplines(self):
        """List all available trained disciplines"""
        model_dir = "./models/trained-models"
        if os.path.exists(model_dir):
            return [d for d in os.listdir(model_dir)
                   if os.path.isdir(os.path.join(model_dir, d))]
        return []

    def get_model_info(self, discipline: str):
        """Get information about a loaded model"""
        model_key = f"{discipline}_model"

        if model_key not in self.loaded_models:
            return {"loaded": False}

        model = self.loaded_models[model_key]

        return {
            "loaded": True,
            "device": str(next(model.parameters()).device),
            "trainable_params": sum(p.numel() for p in model.parameters() if p.requires_grad),
            "total_params": sum(p.numel() for p in model.parameters()),
            "memory_usage": torch.cuda.memory_allocated() if torch.cuda.is_available() else 0
        }


def main():
    """Example usage"""
    loader = DisciplineModelLoader()

    # List available disciplines
    print("Available disciplines:", loader.list_available_disciplines())

    # Load a model
    try:
        model, tokenizer = loader.load_discipline_model("building_operations")

        # Get model info
        info = loader.get_model_info("building_operations")
        print(f"Model info: {info}")

        # Generate response
        prompt = "Analyze this maintenance issue: The HVAC system is making unusual noises and the temperature fluctuates randomly."
        response = loader.generate_response("building_operations", prompt)

        print(f"Prompt: {prompt}")
        print(f"Response: {response}")

    except Exception as e:
        print(f"Error: {e}")


if __name__ == "__main__":
    main()