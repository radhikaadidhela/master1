# Apex interface, abstract class, and virtual class

These are learning examples inspired by the settlement integration scenario in your project notes. They do not represent deployed Western Union code, real settlement amounts, or actual fee rules.

## Remember these three sentences

- **Interface = contract + loose coupling.** It says what an object must do.
- **Abstract class = contract + shared implementation.** It supplies reusable code and can require children to fill in missing behavior.
- **Virtual class = default implementation that can be overridden.** It works directly, and children can customize selected methods.

| Question | Interface | Abstract class | Virtual class |
|---|---|---|---|
| Create an instance directly? | No | No | Yes, with an accessible constructor |
| Contains method bodies? | No | Yes, for concrete methods | Yes |
| Can declare methods without bodies? | Interface signatures | Yes, abstract methods | No abstract methods |
| Child keyword | `implements` | `extends` | `extends` |
| Obligation for a concrete class | Implement required methods | Implement inherited abstract methods | No required override |
| Shared instance state/constructors? | No | Yes | Yes |
| Typical use | Swappable gateways | Common gateway validation with required retrieval | Default policy with optional customization |

## 1. Interface: agree on a capability

**Definition:** An interface declares method signatures. An implementing class provides the behavior.

**Why/when:** Your settlement service should depend on the ability to retrieve a settlement, rather than a particular external-system implementation. This makes replacement and testing easier.

**Example — ISettlementGateway.cls:**

```apex
public interface ISettlementGateway {
    Decimal getSettlement(String agentId);
}
```

There is no method body. The contract is: accept an agent ID and return a Decimal. Notice that interface method declarations omit access modifiers.

**Example — DemoFixedGateway.cls:**

```apex
public class DemoFixedGateway implements ISettlementGateway {
    public Decimal getSettlement(String agentId) {
        return 300.00; // Learning fixture
    }
}
```

Use `implements`. Do not add `override` merely because you implement an interface.

The service receives its dependency through its constructor:

```apex
public class DemoSettlementService {
    private ISettlementGateway gateway;

    public DemoSettlementService(ISettlementGateway gateway) {
        this.gateway = gateway;
    }

    public Decimal getCurrentSettlement(String agentId) {
        return gateway.getSettlement(agentId);
    }
}
```

```text
DemoSettlementService -> ISettlementGateway contract
                             |
                             +-> DemoOrmGateway   -> 1250.00
                             +-> DemoFixedGateway -> 300.00
```

The service code stays the same when the supplied implementation changes. This is loose coupling. You can declare an interface-typed variable, but you cannot write `new ISettlementGateway()`.

## 2. Abstract class: reuse part of the work, require the rest

**Definition:** An abstract class cannot be instantiated directly. It can contain concrete methods, state, constructors, and abstract methods without bodies. An abstract class does not have to declare an abstract method.

**Why/when:** Related gateways may share validation or request preparation, while each gateway must define how it retrieves data.

**Example — SettlementGatewayBase.cls:**

```apex
public abstract class SettlementGatewayBase implements ISettlementGateway {
    protected void validateAgentId(String agentId) {
        if (String.isBlank(agentId)) {
            throw new IllegalArgumentException('Agent ID is required.');
        }
    }

    public abstract Decimal getSettlement(String agentId);
}
```

`validateAgentId()` already has a body. `getSettlement()` has no body and ends with a semicolon. `protected` lets subclasses call the validation helper without exposing it as a public API.

**Example — DemoOrmGateway.cls:**

```apex
public class DemoOrmGateway extends SettlementGatewayBase {
    public override Decimal getSettlement(String agentId) {
        validateAgentId(agentId);
        return 1250.00; // Learning fixture, not a real ORMB response
    }
}
```

The child uses `extends`, reuses the helper, and uses `override` to implement the inherited abstract method. It also inherits the interface relationship, so it can be passed to the service.

```text
getSettlement('A10045')
        -> inherited validation passes
        -> child's retrieval body runs
        -> 1250.00

getSettlement('')
        -> inherited validation throws an exception
        -> retrieval does not run
```

The child explicitly calls validation. Inheritance makes a helper available; it does not automatically execute it. If you need to enforce a common sequence, a concrete base method can call validation and then an abstract retrieval hook.

## 3. Virtual class: use the default or customize it

**Definition:** A virtual class can be instantiated and extended. A method marked `virtual` has a body that a subclass may override.

**Why/when:** You have a usable default policy, but some cases need different behavior.

**Example — SettlementFeePolicy.cls:**

```apex
public virtual class SettlementFeePolicy {
    public virtual Decimal calculateFee(Decimal amount) {
        return amount * 0.02;
    }

    public String getDescription() {
        return 'Learning example: settlement fee policy';
    }
}
```

**Example — PreferredAgentFeePolicy.cls:**

```apex
public class PreferredAgentFeePolicy extends SettlementFeePolicy {
    public override Decimal calculateFee(Decimal amount) {
        return amount * 0.01;
    }
}
```

```apex
SettlementFeePolicy standard = new SettlementFeePolicy();
SettlementFeePolicy preferred = new PreferredAgentFeePolicy();
System.debug(standard.calculateFee(1000));  // 20
System.debug(preferred.calculateFee(1000)); // 10
```

Both variables have the same declared type, but the actual object determines which method runs. This is runtime polymorphism.

```text
standard.calculateFee(1000)  -> base implementation  -> 2% -> 20
preferred.calculateFee(1000) -> child implementation -> 1% -> 10
```

Marking the class `virtual` does not make all its methods overridable. Here, `getDescription()` is inherited but cannot be overridden. A child can call `super.calculateFee(amount)` inside its override if it wants to reuse the parent's calculation.

## How they fit your project scenario

```text
LWC / Flow -> Controller -> Settlement service
                                  |
                         ISettlementGateway
                                  ^ implements
                         Abstract gateway base
                                  ^ extends
                         Concrete ORMB gateway
                                  |
                         Credentials -> MuleSoft -> ORMB

Default fee policy (virtual) <- extends - Preferred fee policy
```

The supplied code stops at fixed values. A real integration needs an agreed API response model, credentials, authorization, error handling, and appropriate logging. A Decimal keeps this lesson focused; a real settlement DTO could include amount, currency, status, and an as-of timestamp.

You do not need all three constructs in every feature. Choose an interface for interchangeable capabilities, an abstract base for related classes that share implementation, and a virtual base when direct default behavior is useful.

## Common interview mistakes

- `implements` is for an interface; `extends` is for a parent class.
- Apex supports one parent class and multiple implemented interfaces.
- A concrete child must implement inherited abstract methods. An abstract child can defer that work.
- An abstract class can also contain virtual methods with optional overrides and ordinary concrete methods that cannot be overridden.
- The interface defines signatures; business validation must still be implemented and enforced.
- Inheritance does not grant sharing, CRUD/FLS, or external-system authorization.

## Run the examples

Each `.cls` file is one top-level Apex class or interface. Save them in a Salesforce sandbox using Developer Console or add them to an existing Salesforce DX project with matching metadata files. This folder is a learning collection, not a standalone deployable DX project.

Once the classes are saved, paste `demo.apex` into Execute Anonymous. Expected debug values:

```text
ORMB demo settlement: 1250.00
Fixed demo settlement: 300.00
Default fee: 20.00
Preferred fee: 10.00
Validation: Agent ID is required.
```

Decimal formatting in logs can vary. The numeric values are what matter. These examples were not compiled or executed against a Salesforce org during authoring.

## Spoken interview answer: about 30 seconds

"An interface is a contract that gives loose coupling. For example, a settlement service can depend on ISettlementGateway and use different gateway implementations. An abstract class provides shared code, such as validation, while requiring a child to implement settlement retrieval. A virtual class provides working default behavior, such as a fee calculation, that a child can optionally override. I use implements for interfaces, extends for parent classes, and override for inherited abstract or virtual methods."

## Official references

- [Salesforce Apex Developer Guide](https://resources.docs.salesforce.com/latest/latest/en-us/sfdc/pdf/salesforce_apex_developer_guide.pdf): class definitions, interfaces, and inheritance.
- [Access modifiers on abstract and override methods](https://help.salesforce.com/s/articleView?id=release-notes.rn_apex_access_modifier.htm&language=en_US&release=258&type=5): API 65.0 and later require protected, public, or global on those methods. The examples use explicit modifiers.
