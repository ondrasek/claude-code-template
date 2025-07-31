"""
Choreography Patterns for Specialist Component Coordination

This module demonstrates distributed coordination patterns where specialist components
coordinate through choreography rather than central orchestration.

Complexity Analysis:
- Communication Paths: O(N²) for full mesh, O(N) for event bus
- Protocol Complexity: Measured by state transitions and message types
- Failure Propagation: Analyzed through dependency graphs
"""

import asyncio
import json
import time
import logging
from abc import ABC, abstractmethod
from dataclasses import dataclass, field
from enum import Enum
from typing import Dict, List, Set, Optional, Callable, Any
from collections import defaultdict
import uuid
import statistics


class MessageType(Enum):
    """Event types for choreographed coordination"""
    TASK_REQUEST = "task_request"
    TASK_ACCEPTED = "task_accepted" 
    TASK_COMPLETED = "task_completed"
    TASK_FAILED = "task_failed"
    RESOURCE_AVAILABLE = "resource_available"
    RESOURCE_CLAIMED = "resource_claimed"
    HEALTH_CHECK = "health_check"
    COORDINATION_SYNC = "coordination_sync"


@dataclass
class Message:
    """Message structure for choreographed communication"""
    id: str = field(default_factory=lambda: str(uuid.uuid4()))
    type: MessageType = MessageType.TASK_REQUEST
    sender: str = ""
    recipient: Optional[str] = None  # None for broadcast
    payload: Dict[str, Any] = field(default_factory=dict)
    timestamp: float = field(default_factory=time.time)
    correlation_id: Optional[str] = None


@dataclass
class ComplexityMetrics:
    """Metrics for measuring coordination complexity"""
    communication_paths: int = 0
    protocol_states: int = 0
    message_types: int = 0
    coordination_overhead_ms: float = 0.0
    failure_cascade_depth: int = 0
    distributed_bottlenecks: List[str] = field(default_factory=list)


class EventBus:
    """Distributed event bus for choreographed coordination"""
    
    def __init__(self):
        self.subscribers: Dict[MessageType, List[Callable]] = defaultdict(list)
        self.message_history: List[Message] = []
        self.metrics = ComplexityMetrics()
        self.active_conversations: Dict[str, List[Message]] = defaultdict(list)
        
    async def publish(self, message: Message):
        """Publish message to all subscribers"""
        start_time = time.time()
        
        # Track message for complexity analysis
        self.message_history.append(message)
        if message.correlation_id:
            self.active_conversations[message.correlation_id].append(message)
            
        # Broadcast to subscribers
        subscribers = self.subscribers.get(message.type, [])
        if subscribers:
            await asyncio.gather(*[
                self._safe_notify(subscriber, message) 
                for subscriber in subscribers
            ])
            
        # Update metrics
        self.metrics.coordination_overhead_ms += (time.time() - start_time) * 1000
        
    async def _safe_notify(self, subscriber: Callable, message: Message):
        """Safely notify subscriber with error handling"""
        try:
            if asyncio.iscoroutinefunction(subscriber):
                await subscriber(message)
            else:
                subscriber(message)
        except Exception as e:
            logging.error(f"Subscriber error: {e}")
            # Track failure propagation
            failure_msg = Message(
                type=MessageType.TASK_FAILED,
                sender="event_bus",
                payload={"error": str(e), "original_message": message.id}
            )
            await self.publish(failure_msg)
    
    def subscribe(self, message_type: MessageType, handler: Callable):
        """Subscribe to message type"""
        self.subscribers[message_type].append(handler)
        self.metrics.communication_paths += 1
        
    def calculate_complexity(self) -> ComplexityMetrics:
        """Calculate current system complexity metrics"""
        # Communication path analysis
        total_paths = sum(len(handlers) for handlers in self.subscribers.values())
        
        # Protocol complexity - unique state transitions
        unique_transitions = set()
        for conversation in self.active_conversations.values():
            for i in range(len(conversation) - 1):
                transition = (conversation[i].type, conversation[i+1].type)
                unique_transitions.add(transition)
                
        # Message type diversity
        message_types = len(set(msg.type for msg in self.message_history))
        
        # Failure cascade analysis
        max_cascade_depth = self._analyze_failure_cascades()
        
        # Distributed bottleneck detection
        bottlenecks = self._detect_bottlenecks()
        
        self.metrics.communication_paths = total_paths
        self.metrics.protocol_states = len(unique_transitions)
        self.metrics.message_types = message_types
        self.metrics.failure_cascade_depth = max_cascade_depth
        self.metrics.distributed_bottlenecks = bottlenecks
        
        return self.metrics
    
    def _analyze_failure_cascades(self) -> int:
        """Analyze maximum failure cascade depth"""
        max_depth = 0
        for conversation in self.active_conversations.values():
            failure_depth = 0
            current_depth = 0
            
            for msg in conversation:
                if msg.type == MessageType.TASK_FAILED:
                    current_depth += 1
                    max_depth = max(max_depth, current_depth)
                else:
                    current_depth = 0
                    
        return max_depth
    
    def _detect_bottlenecks(self) -> List[str]:
        """Detect distributed coordination bottlenecks"""
        # Analyze message frequency by sender
        sender_counts = defaultdict(int)
        for msg in self.message_history[-100:]:  # Recent messages
            sender_counts[msg.sender] += 1
            
        # Identify high-frequency senders as potential bottlenecks
        avg_count = statistics.mean(sender_counts.values()) if sender_counts else 0
        bottlenecks = [
            sender for sender, count in sender_counts.items()
            if count > avg_count * 2
        ]
        
        return bottlenecks


class SpecialistComponent(ABC):
    """Base class for specialist components in choreographed system"""
    
    def __init__(self, name: str, event_bus: EventBus):
        self.name = name
        self.event_bus = event_bus
        self.state = "idle"
        self.capabilities: Set[str] = set()
        self.current_tasks: Dict[str, Dict] = {}
        self.health_status = "healthy"
        
        # Register for coordination messages
        self.event_bus.subscribe(MessageType.HEALTH_CHECK, self._handle_health_check)
        
    @abstractmethod
    async def process_task(self, task_data: Dict[str, Any]) -> Dict[str, Any]:
        """Process assigned task - implemented by specialists"""
        pass
    
    async def _handle_health_check(self, message: Message):
        """Respond to health check requests"""
        response = Message(
            type=MessageType.COORDINATION_SYNC,
            sender=self.name,
            payload={
                "health": self.health_status,
                "state": self.state,
                "active_tasks": len(self.current_tasks),
                "capabilities": list(self.capabilities)
            },
            correlation_id=message.correlation_id
        )
        await self.event_bus.publish(response)


class CodeAnalysisSpecialist(SpecialistComponent):
    """Specialist for code analysis tasks"""
    
    def __init__(self, name: str, event_bus: EventBus):
        super().__init__(name, event_bus)
        self.capabilities = {"static_analysis", "complexity_measurement", "pattern_detection"}
        
        # Subscribe to relevant coordination events
        self.event_bus.subscribe(MessageType.TASK_REQUEST, self._handle_task_request)
        self.event_bus.subscribe(MessageType.RESOURCE_AVAILABLE, self._handle_resource_available)
        
    async def _handle_task_request(self, message: Message):
        """Handle incoming task requests through choreography"""
        task_type = message.payload.get("type")
        
        if task_type in self.capabilities and self.state == "idle":
            # Accept task through choreography
            acceptance = Message(
                type=MessageType.TASK_ACCEPTED,
                sender=self.name,
                recipient=message.sender,
                payload={"task_id": message.id, "estimated_duration": 5.0},
                correlation_id=message.correlation_id
            )
            await self.event_bus.publish(acceptance)
            
            # Process task
            self.state = "processing"
            self.current_tasks[message.id] = message.payload
            
            try:
                result = await self.process_task(message.payload)
                
                # Publish completion
                completion = Message(
                    type=MessageType.TASK_COMPLETED,
                    sender=self.name,
                    recipient=message.sender,
                    payload={"task_id": message.id, "result": result},
                    correlation_id=message.correlation_id
                )
                await self.event_bus.publish(completion)
                
            except Exception as e:
                # Publish failure
                failure = Message(
                    type=MessageType.TASK_FAILED,
                    sender=self.name,
                    recipient=message.sender,
                    payload={"task_id": message.id, "error": str(e)},
                    correlation_id=message.correlation_id
                )
                await self.event_bus.publish(failure)
            
            finally:
                self.state = "idle"
                del self.current_tasks[message.id]
                
                # Announce availability
                availability = Message(
                    type=MessageType.RESOURCE_AVAILABLE,
                    sender=self.name,
                    payload={"capabilities": list(self.capabilities)}
                )
                await self.event_bus.publish(availability)
    
    async def _handle_resource_available(self, message: Message):
        """Coordinate with other specialists when resources become available"""
        if message.sender != self.name:
            # Could coordinate for complex multi-specialist tasks
            logging.info(f"{self.name} noted {message.sender} is available")
    
    async def process_task(self, task_data: Dict[str, Any]) -> Dict[str, Any]:
        """Simulate code analysis work"""
        await asyncio.sleep(0.1)  # Simulate processing time
        
        return {
            "complexity_score": 42,
            "patterns_found": ["singleton", "factory"],
            "issues": ["high_complexity", "missing_tests"]
        }


class TestGenerationSpecialist(SpecialistComponent):
    """Specialist for test generation tasks"""
    
    def __init__(self, name: str, event_bus: EventBus):
        super().__init__(name, event_bus)
        self.capabilities = {"unit_test_generation", "integration_test_generation", "property_based_testing"}
        
        self.event_bus.subscribe(MessageType.TASK_REQUEST, self._handle_task_request)
        self.event_bus.subscribe(MessageType.TASK_COMPLETED, self._handle_upstream_completion)
        
    async def _handle_task_request(self, message: Message):
        """Handle test generation requests"""
        task_type = message.payload.get("type")
        
        if task_type in self.capabilities and self.state == "idle":
            acceptance = Message(
                type=MessageType.TASK_ACCEPTED,  
                sender=self.name,
                recipient=message.sender,
                payload={"task_id": message.id, "estimated_duration": 3.0},
                correlation_id=message.correlation_id
            )
            await self.event_bus.publish(acceptance)
            
            self.state = "processing"
            self.current_tasks[message.id] = message.payload
            
            try:
                result = await self.process_task(message.payload)
                
                completion = Message(
                    type=MessageType.TASK_COMPLETED,
                    sender=self.name,
                    recipient=message.sender,
                    payload={"task_id": message.id, "result": result},
                    correlation_id=message.correlation_id
                )
                await self.event_bus.publish(completion)
                
            except Exception as e:
                failure = Message(
                    type=MessageType.TASK_FAILED,
                    sender=self.name,
                    recipient=message.sender,
                    payload={"task_id": message.id, "error": str(e)},
                    correlation_id=message.correlation_id
                )
                await self.event_bus.publish(failure)
            
            finally:
                self.state = "idle"
                del self.current_tasks[message.id]
    
    async def _handle_upstream_completion(self, message: Message):
        """React to upstream task completions for choreographed workflows"""
        if message.sender != self.name and "analysis" in message.payload.get("result", {}):
            # Automatically generate tests based on analysis results
            test_request = Message(
                type=MessageType.TASK_REQUEST,
                sender=self.name,
                recipient=self.name,  # Self-assignment
                payload={
                    "type": "unit_test_generation",
                    "analysis_result": message.payload["result"]
                },
                correlation_id=message.correlation_id
            )
            await self.event_bus.publish(test_request)
    
    async def process_task(self, task_data: Dict[str, Any]) -> Dict[str, Any]:
        """Simulate test generation work"""
        await asyncio.sleep(0.08)  # Simulate processing time
        
        return {
            "tests_generated": 15,
            "coverage_estimate": 85.5,
            "test_types": ["unit", "integration", "property"]
        }


class DocumentationSpecialist(SpecialistComponent):
    """Specialist for documentation generation tasks"""
    
    def __init__(self, name: str, event_bus: EventBus):
        super().__init__(name, event_bus)
        self.capabilities = {"api_documentation", "code_documentation", "architecture_diagrams"}
        
        self.event_bus.subscribe(MessageType.TASK_REQUEST, self._handle_task_request)
        self.event_bus.subscribe(MessageType.TASK_COMPLETED, self._handle_upstream_completion)
        
    async def _handle_task_request(self, message: Message):
        """Handle documentation requests"""
        task_type = message.payload.get("type")
        
        if task_type in self.capabilities and self.state == "idle":
            acceptance = Message(
                type=MessageType.TASK_ACCEPTED,
                sender=self.name,
                recipient=message.sender,
                payload={"task_id": message.id, "estimated_duration": 4.0},
                correlation_id=message.correlation_id
            )
            await self.event_bus.publish(acceptance)
            
            self.state = "processing"
            self.current_tasks[message.id] = message.payload
            
            try:
                result = await self.process_task(message.payload)
                
                completion = Message(
                    type=MessageType.TASK_COMPLETED,
                    sender=self.name,
                    recipient=message.sender,
                    payload={"task_id": message.id, "result": result},
                    correlation_id=message.correlation_id
                )
                await self.event_bus.publish(completion)
                
            except Exception as e:
                failure = Message(
                    type=MessageType.TASK_FAILED,
                    sender=self.name,
                    recipient=message.sender,
                    payload={"task_id": message.id, "error": str(e)},
                    correlation_id=message.correlation_id
                )
                await self.event_bus.publish(failure)
            
            finally:
                self.state = "idle"
                del self.current_tasks[message.id]
    
    async def _handle_upstream_completion(self, message: Message):
        """Generate documentation based on completed analysis/testing"""
        if message.sender != self.name:
            result = message.payload.get("result", {})
            if "complexity_score" in result or "tests_generated" in result:
                # Auto-generate documentation based on analysis/test results
                doc_request = Message(
                    type=MessageType.TASK_REQUEST,
                    sender=self.name,
                    recipient=self.name,
                    payload={
                        "type": "code_documentation",
                        "source_data": result
                    },
                    correlation_id=message.correlation_id
                )
                await self.event_bus.publish(doc_request)
    
    async def process_task(self, task_data: Dict[str, Any]) -> Dict[str, Any]:
        """Simulate documentation generation work"""
        await asyncio.sleep(0.12)  # Simulate processing time
        
        return {
            "documentation_pages": 8,
            "diagrams_created": 3,
            "api_endpoints_documented": 12
        }


class PerformanceMonitoringSpecialist(SpecialistComponent):
    """Specialist for monitoring choreography performance"""
    
    def __init__(self, name: str, event_bus: EventBus):
        super().__init__(name, event_bus)
        self.capabilities = {"performance_monitoring", "bottleneck_detection", "scalability_analysis"}
        self.performance_data: List[Dict] = []
        
        # Monitor all message types for performance analysis
        for msg_type in MessageType:
            self.event_bus.subscribe(msg_type, self._monitor_message)
    
    async def _monitor_message(self, message: Message):
        """Monitor all messages for performance analysis"""
        self.performance_data.append({
            "timestamp": message.timestamp,
            "type": message.type.value,
            "sender": message.sender,
            "latency": time.time() - message.timestamp
        })
        
        # Keep only recent data
        if len(self.performance_data) > 1000:
            self.performance_data = self.performance_data[-500:]
    
    async def process_task(self, task_data: Dict[str, Any]) -> Dict[str, Any]:
        """Analyze choreography performance"""
        if not self.performance_data:
            return {"status": "no_data"}
            
        # Calculate performance metrics
        latencies = [d["latency"] for d in self.performance_data]
        
        return {
            "avg_latency_ms": statistics.mean(latencies) * 1000,
            "max_latency_ms": max(latencies) * 1000,
            "message_throughput": len(self.performance_data) / 60,  # per minute
            "bottleneck_analysis": self._analyze_bottlenecks()
        }
    
    def _analyze_bottlenecks(self) -> Dict[str, Any]:
        """Analyze system bottlenecks"""
        sender_latencies = defaultdict(list)
        for data in self.performance_data:
            sender_latencies[data["sender"]].append(data["latency"])
            
        bottlenecks = {}
        for sender, latencies in sender_latencies.items():
            if len(latencies) > 5:  # Minimum sample size
                avg_latency = statistics.mean(latencies)
                bottlenecks[sender] = {
                    "avg_latency_ms": avg_latency * 1000,
                    "message_count": len(latencies)
                }
                
        return bottlenecks


class ChoreographyCoordinator:
    """Coordinates multi-specialist choreography workflows"""
    
    def __init__(self, event_bus: EventBus):
        self.event_bus = event_bus
        self.specialists: Dict[str, SpecialistComponent] = {}
        self.active_workflows: Dict[str, Dict] = {}
        
    def register_specialist(self, specialist: SpecialistComponent):
        """Register specialist component"""
        self.specialists[specialist.name] = specialist
        
    async def execute_choreographed_workflow(self, workflow_spec: Dict[str, Any]) -> Dict[str, Any]:
        """Execute a choreographed workflow across multiple specialists"""
        correlation_id = str(uuid.uuid4())
        workflow_name = workflow_spec.get("name", "unnamed_workflow")
        
        # Track workflow
        self.active_workflows[correlation_id] = {
            "name": workflow_name,
            "start_time": time.time(),
            "tasks": workflow_spec.get("tasks", []),
            "results": {}
        }
        
        # Initiate choreographed tasks
        tasks = workflow_spec.get("tasks", [])
        for task in tasks:
            task_message = Message(
                type=MessageType.TASK_REQUEST,
                sender="coordinator",
                payload=task,
                correlation_id=correlation_id
            )
            await self.event_bus.publish(task_message)
            
        # Wait for choreography to complete
        return await self._wait_for_workflow_completion(correlation_id, timeout=30.0)
    
    async def _wait_for_workflow_completion(self, correlation_id: str, timeout: float) -> Dict[str, Any]:
        """Wait for choreographed workflow to complete"""
        start_time = time.time()
        
        while time.time() - start_time < timeout:
            # Check if all tasks in workflow are complete
            workflow = self.active_workflows.get(correlation_id)
            if not workflow:
                break
                
            # Collect completed task results from event bus
            conversation = self.event_bus.active_conversations.get(correlation_id, [])
            completed_tasks = [
                msg for msg in conversation 
                if msg.type == MessageType.TASK_COMPLETED
            ]
            
            if len(completed_tasks) >= len(workflow["tasks"]):
                # Workflow complete
                results = {
                    "workflow_name": workflow["name"],
                    "duration_ms": (time.time() - workflow["start_time"]) * 1000,
                    "task_results": [msg.payload["result"] for msg in completed_tasks],
                    "complexity_metrics": self.event_bus.calculate_complexity()
                }
                
                del self.active_workflows[correlation_id]
                return results
                
            await asyncio.sleep(0.1)
            
        # Timeout
        return {
            "status": "timeout",
            "correlation_id": correlation_id,
            "partial_results": []
        }


# Example Usage and Complexity Analysis

async def demonstrate_choreography_patterns():
    """Demonstrate choreographed specialist coordination with complexity analysis"""
    
    # Initialize choreography infrastructure
    event_bus = EventBus()
    coordinator = ChoreographyCoordinator(event_bus)
    
    # Create specialist components
    code_analyst = CodeAnalysisSpecialist("code_analyst", event_bus)
    test_generator = TestGenerationSpecialist("test_generator", event_bus)
    doc_generator = DocumentationSpecialist("doc_generator", event_bus)
    performance_monitor = PerformanceMonitoringSpecialist("perf_monitor", event_bus)
    
    # Register specialists
    for specialist in [code_analyst, test_generator, doc_generator, performance_monitor]:
        coordinator.register_specialist(specialist)
    
    print("=== CHOREOGRAPHY PATTERN DEMONSTRATION ===\n")
    
    # Example 1: Simple choreographed workflow
    print("1. SIMPLE CHOREOGRAPHED WORKFLOW")
    simple_workflow = {
        "name": "code_quality_check",
        "tasks": [
            {"type": "static_analysis", "target": "user_service.py"},
            {"type": "unit_test_generation", "target": "user_service.py"}
        ]
    }
    
    result1 = await coordinator.execute_choreographed_workflow(simple_workflow)
    print(f"Workflow Duration: {result1['duration_ms']:.2f} ms")
    print(f"Tasks Completed: {len(result1['task_results'])}")
    
    # Example 2: Complex multi-specialist choreography
    print("\n2. COMPLEX MULTI-SPECIALIST CHOREOGRAPHY")
    complex_workflow = {
        "name": "full_pipeline",
        "tasks": [
            {"type": "static_analysis", "target": "payment_service.py"},
            {"type": "complexity_measurement", "target": "payment_service.py"},
            {"type": "unit_test_generation", "target": "payment_service.py"},
            {"type": "integration_test_generation", "target": "payment_service.py"},
            {"type": "api_documentation", "target": "payment_service.py"},
            {"type": "architecture_diagrams", "target": "payment_service.py"}
        ]
    }
    
    result2 = await coordinator.execute_choreographed_workflow(complex_workflow)
    print(f"Workflow Duration: {result2['duration_ms']:.2f} ms")
    print(f"Tasks Completed: {len(result2['task_results'])}")
    
    # Complexity Analysis
    print("\n3. COMPLEXITY METRICS ANALYSIS")
    metrics = result2['complexity_metrics']
    
    print(f"Communication Paths: {metrics.communication_paths}")
    print(f"Protocol States: {metrics.protocol_states}")
    print(f"Message Types: {metrics.message_types}")
    print(f"Coordination Overhead: {metrics.coordination_overhead_ms:.2f} ms")
    print(f"Failure Cascade Depth: {metrics.failure_cascade_depth}")
    print(f"Distributed Bottlenecks: {metrics.distributed_bottlenecks}")
    
    # Performance Analysis
    print("\n4. PERFORMANCE ANALYSIS")
    perf_analysis = await performance_monitor.process_task({"type": "performance_analysis"})
    if perf_analysis.get("status") != "no_data":
        print(f"Average Message Latency: {perf_analysis['avg_latency_ms']:.2f} ms")
        print(f"Maximum Message Latency: {perf_analysis['max_latency_ms']:.2f} ms")
        print(f"Message Throughput: {perf_analysis['message_throughput']:.1f} msg/min")
        
        print("\nBottleneck Analysis:")
        for component, data in perf_analysis['bottleneck_analysis'].items():
            print(f"  {component}: {data['avg_latency_ms']:.2f} ms avg, {data['message_count']} messages")
    
    # Failure Scenario Analysis
    print("\n5. FAILURE SCENARIO ANALYSIS")
    await simulate_failure_scenarios(coordinator, event_bus)
    
    return {
        "simple_workflow_result": result1,
        "complex_workflow_result": result2,
        "final_metrics": metrics,
        "performance_analysis": perf_analysis
    }


async def simulate_failure_scenarios(coordinator: ChoreographyCoordinator, event_bus: EventBus):
    """Simulate and analyze failure propagation patterns"""
    
    # Simulate component failure
    print("Simulating component failure scenario...")
    
    # Create a failing specialist
    class FailingSpecialist(SpecialistComponent):
        async def process_task(self, task_data: Dict[str, Any]) -> Dict[str, Any]:
            raise Exception("Simulated component failure")
    
    failing_specialist = FailingSpecialist("failing_component", event_bus)
    failing_specialist.capabilities = {"failing_task"}
    event_bus.subscribe(MessageType.TASK_REQUEST, failing_specialist._handle_task_request)
    
    # Execute workflow with failure
    failure_workflow = {
        "name": "failure_test",
        "tasks": [
            {"type": "static_analysis", "target": "test.py"},
            {"type": "failing_task", "target": "test.py"}  # This will fail
        ]
    }
    
    failure_result = await coordinator.execute_choreographed_workflow(failure_workflow)
    
    # Analyze failure propagation
    final_metrics = event_bus.calculate_complexity()
    print(f"Failure Cascade Depth: {final_metrics.failure_cascade_depth}")
    print(f"Failed Messages in History: {len([m for m in event_bus.message_history if m.type == MessageType.TASK_FAILED])}")
    
    # Analyze conversation patterns during failure
    for corr_id, conversation in event_bus.active_conversations.items():
        failure_msgs = [m for m in conversation if m.type == MessageType.TASK_FAILED]
        if failure_msgs:
            print(f"Conversation {corr_id}: {len(failure_msgs)} failures detected")


def calculate_theoretical_complexity(num_specialists: int, choreography_patterns: List[str]) -> Dict[str, float]:
    """Calculate theoretical complexity for different choreography patterns"""
    
    complexity_analysis = {}
    
    # Full Mesh Communication (worst case)
    full_mesh_paths = num_specialists * (num_specialists - 1)
    complexity_analysis["full_mesh_communication_paths"] = full_mesh_paths
    complexity_analysis["full_mesh_complexity"] = full_mesh_paths ** 2  # O(N²)
    
    # Event Bus Pattern (current implementation)
    event_bus_paths = num_specialists  # Each specialist connects to bus
    complexity_analysis["event_bus_communication_paths"] = event_bus_paths
    complexity_analysis["event_bus_complexity"] = event_bus_paths * len(MessageType)  # O(N*M)
    
    # Hub and Spoke Pattern
    hub_spoke_paths = 2 * num_specialists  # Bi-directional to hub
    complexity_analysis["hub_spoke_communication_paths"] = hub_spoke_paths
    complexity_analysis["hub_spoke_complexity"] = hub_spoke_paths  # O(N)
    
    # Chain Pattern
    chain_paths = num_specialists - 1  # Sequential connections
    complexity_analysis["chain_communication_paths"] = chain_paths
    complexity_analysis["chain_complexity"] = chain_paths  # O(N-1)
    
    return complexity_analysis


if __name__ == "__main__":
    # Run choreography demonstration
    result = asyncio.run(demonstrate_choreography_patterns())
    
    # Calculate theoretical complexity comparisons
    print("\n6. THEORETICAL COMPLEXITY COMPARISON")
    theoretical = calculate_theoretical_complexity(4, ["event_bus", "full_mesh", "hub_spoke", "chain"])
    
    for pattern, complexity in theoretical.items():
        print(f"{pattern}: {complexity}")
    
    print(f"\nActual Implementation Complexity: {result['final_metrics'].communication_paths} paths")
    print("Choreography pattern successfully demonstrates distributed specialist coordination!")