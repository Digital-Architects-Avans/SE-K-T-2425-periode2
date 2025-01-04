namespace Code_DetermineShippingCosts;
using NUnit.Framework;

public class DetermineShippingCostsTests
{
    private ClassAssignmentAvans _classAssignment;

    [SetUp]
    public void Setup()
    {
        _classAssignment = new ClassAssignmentAvans();
    }

    [Test]
    [TestCase("Ground")]
    [TestCase("InStore")]
    [TestCase("NextDayAir")]
    [TestCase("SecondDayAir")]
    [TestCase("InvalidShippingType")]
    public void NoCalc_ShouldReturnZero(string shippingType)
    {
        var result = _classAssignment.ShippingCosts(false, shippingType, 1500);

        Assert.That(result, Is.EqualTo(0));
    }

    [Test]
    [TestCase("Ground")]
    [TestCase("InStore")]
    [TestCase("NextDayAir")]
    [TestCase("SecondDayAir")]
    [TestCase("InvalidShippingType")]
    public void AboveThreshold_ShouldReturnZero(string shippingType)
    {
        var result = _classAssignment.ShippingCosts(true, shippingType, 1501);

        Assert.That(result, Is.EqualTo(0));
    }

    [Test]
    [TestCase("Ground", 100)]
    [TestCase("InStore", 50)]
    [TestCase("NextDayAir", 250)]
    [TestCase("SecondDayAir", 125)]
    [TestCase("InvalidShippingType", 0)]
    public void BelowThreshold_ShouldReturnCost(string shippingType, double expectedCost)
    {
        var result = _classAssignment.ShippingCosts(true, shippingType, 1500);

        Assert.That(result, Is.EqualTo(expectedCost));
    }
}